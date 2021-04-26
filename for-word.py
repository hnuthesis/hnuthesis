import urllib.request
import os
import re
import hashlib
import argparse
from pathlib import Path
from multiprocessing import Pool

parser = argparse.ArgumentParser()
parser.add_argument(
    '--source',
    type=str,
    help=
    'source directory where the formulas in the TeX files will be rasterized')
parser.add_argument('--download_path',
                    type=str,
                    help='directory where rasterized formulas will be saved')
parser.add_argument(
    '--inline_formula_rasterisation_keywords',
    type=str,
    nargs='+',
    default=['bmatrix'],
    help=
    'Specify the keywords in inline formulas that will be rasterized, if it looks badly if directly converted into docx files'
)
args = parser.parse_args()


def download_formula(formula, filepath):
    '''
    Download the PNG files for {formula} into {filepath}
    '''
    if os.path.isfile(filepath):
        print(f'Skip downloading {filepath}')
        return
    pairs = [
        (r'\begin{equation}', r'\end{equation}'),
        (r'\begin{equation*}', r'\end{equation*}'),
        ('$', '$'),
    ]
    for pair in pairs:
        if formula.startswith(pair[0]):
            assert formula.endswith(pair[1])
            formula = formula[len(pair[0]):-len(pair[1])]
    base = r'https://latex.codecogs.com/png.latex?'
    query = r'\dpi{600}&space;\bg_white&space;' + formula.replace(
        ' ', '&space;').replace('\n', '')
    count = 0
    while True:
        try:
            urllib.request.urlretrieve(base + query, filepath)
            print(f'Finish downloading {filepath}')
            break
        except Exception as e:
            print(e)
            count += 1
            if count == 3:
                raise ValueError(
                    f'Error on downloading {filepath} for formula {formula}')


def rasterize():
    tex_files = [
        os.path.join(dp, f) for dp, dn, filenames in os.walk(args.source)
        for f in filenames if os.path.splitext(f)[1] == '.tex'
    ]

    adjustbox_imported = False

    Path(args.download_path).mkdir(exist_ok=True)
    for tex_file in tex_files:
        with open(tex_file, 'r', encoding='utf-8') as f:
            text = f.read()

        if r'\usepackage[export]{adjustbox}' in text:
            adjustbox_imported = True

        matches = []
        # rasterize the formulas in equation environment
        matches.extend(
            re.findall(r'\\begin\{equation\}.*?\\end\{equation\}', text,
                       re.DOTALL))
        matches.extend(
            re.findall(r'\\begin\{equation\*\}.*?\\end\{equation\*\}', text,
                       re.DOTALL))
        # also rasterize the inline formulas if containing the keywords
        matches.extend([
            x for x in re.findall(r'\$.*?\$', text) if any([
                keyword in x
                for keyword in args.inline_formula_rasterisation_keywords
            ])
        ])
        matches = list(set(matches))

        filepaths = [
            os.path.join(
                args.download_path,
                f"{hashlib.md5(match.encode('utf-8')).hexdigest()[:8]}.png")
            for match in matches
        ]

        # speed up the downloading of formula pictures
        with Pool(processes=16) as pool:
            pool.starmap(download_formula, zip(matches, filepaths))

        for match, filepath in zip(matches, filepaths):
            if match.startswith(r'\begin{equation}'):
                template = '''
                    \\begin{equation}
                        \\includegraphics[valign=c,scale=0.18]{#FILEPATH#} #LABEL#
                    \\end{equation}
                '''
            elif match.startswith(r'\begin{equation*}'):
                template = '''
                    \\begin{equation*}
                        \\includegraphics[valign=c,scale=0.18]{#FILEPATH#}
                    \\end{equation*}
                '''
            elif match.startswith('$'):
                template = '\\,\\raisebox{-.15\\baselineskip}{\\includegraphics[scale=0.18]{#FILEPATH#}}\\,'
            else:
                # unexpected error, check it manually
                import ipdb
                ipdb.set_trace()

            template = template.replace(
                '#FILEPATH#',
                os.path.abspath(filepath).replace('\\', '/'))
            label = re.search(r'\\label\{(.+?)\}', match)
            if label:
                template = template.replace('#LABEL#',
                                            f'\\label{{{label.group(1)}}}')
            else:
                template = template.replace('#LABEL#', '')
            text = text.replace(match, template)

        with open(tex_file, 'w', encoding='utf-8') as f:
            f.write(text)

    if not adjustbox_imported:
        for tex_file in tex_files:
            with open(tex_file, 'r', encoding='utf-8') as f:
                text = f.read()

            if r'\begin{document}' in text:
                text = text.replace(
                    r'\begin{document}',
                    r'\usepackage[export]{adjustbox} \begin{document}')

            with open(tex_file, 'w', encoding='utf-8') as f:
                f.write(text)


if __name__ == '__main__':
    rasterize()
