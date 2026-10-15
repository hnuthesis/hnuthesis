# 湖南大学硕士学位论文 LaTeX 模板

[![Compile and publish the release](https://github.com/yusanshi/hnuthesis/actions/workflows/main.yml/badge.svg)](https://github.com/yusanshi/hnuthesis/actions/workflows/main.yml) [![GitHub Releases](https://img.shields.io/github/v/release/yusanshi/hnuthesis)](https://github.com/yusanshi/hnuthesis/releases/latest)

本项目是湖南大学学位论文 LaTeX 模板，默认格式面向硕士论文，按《[湖南大学研究生学位论文撰写规范](http://gra.hnu.edu.cn/info/1276/3444.htm)》制作。模板的博士选项仅切换学位名称和英文学位字段，**不代表已完成博士论文规范适配**。请在使用前核对学校、学院当年的要求；格式正确性不作保证。

下载：[GitHub Releases](https://github.com/yusanshi/hnuthesis/releases)、[Overleaf 项目预览](https://www.overleaf.com/read/rpzgkfpfwntd#3a7618)。

## 文件结构

- `main.tex`：编译入口及论文结构；
- `metadata.tex`：标题、作者、学院、导师等元数据示例，复制后按需修改；
- `hnuthesis.cls`：湖南大学排版规范及文档类选项；
- `chapters/`：论文内容示例，各章节文件可删除或替换；`main.tex` 会跳过不存在的章节文件；
- `references.bib`：BibTeX 文献数据库；
- `figures/`：图片资源；
- `run.sh`：本地编译 `main.pdf`。

## 编译

需要支持 XeLaTeX、`latexmk` 和中文排版的 LaTeX 发行版。请从项目根目录执行：

```bash
latexmk -xelatex -halt-on-error main.tex
# 或
./run.sh
```

模板使用仓库中的 `simsun.ttc` 和 `simhei.ttf` 字体文件，并使用 Times New Roman。若缺少 Times New Roman，请按本机发行版配置相应字体。VS Code 用户可使用 LaTeX Workshop 的项目配方。

GitHub Actions 的 PR 检查会编译 TeX 文档；推送 `v*.*.*` 标签会发布 `main.pdf`。

## 文档类选项

可组合使用以下选项，例如：

```latex
\documentclass[doctor,blind,pdf,authoryear]{hnuthesis}
```

- 学位：默认 `master`；`doctor` 显示博士学位名称。博士版尚未全面适配规范。
- 引用：默认 `super`（上标数字）；`numbers` 为行内数字；`authoryear` 使用 `plainnat` 著录格式。硕士默认数值引用使用仓库的 `hnunumerical.bst`。
- 输出：默认 `print`；`pdf` 启用彩色链接并切换为单面排版。
- `blind`：封面及 PDF 元数据隐藏作者、学号、导师和本科院校信息。盲审提交前还须自行检查正文、致谢、成果列表、图片及其他文件中的身份信息；此选项不对正文做匿名化。

学校以外的论文规范、封面和声明页尚未作为独立样式实现。使用其他学校或特殊培养类型时，应先确认规范要求，不要仅依赖切换学位选项。

## Word 转换

当前 `run.sh` 和 GitHub Release 只生成 `main.pdf`，不生成 `main-for-word.pdf`。仓库中的 `for-word.py` 是未集成的旧脚本，不属于受支持的构建流程；它会改写源 TeX 文件并向外部公式服务请求图片，不建议直接对论文源文件运行。

## 许可

本项目基于 [Gwinel/Latex](https://github.com/Gwinel/Latex/)，许可信息见 [`LICENSE`](LICENSE)。
