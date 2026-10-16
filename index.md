---
layout: default
title: HNU Thesis
description: 湖南大学学位论文 LaTeX 模板 · 专注规范排版，让写作回归内容
---

# 把时间留给研究，让排版回归规范。

为湖南大学硕士学位论文准备的 XeLaTeX 模板。封面、摘要、目录、正文和参考文献的版式已经就绪，你只需要写内容。

<div class="hero-actions">
  <a class="button button-primary" href="https://github.com/hnuthesis/hnuthesis/releases/latest">下载最新版本</a>
  <a class="button" href="https://github.com/hnuthesis/hnuthesis/releases/download/preview/hnuthesis-preview.pdf">查看示例 PDF</a>
  <a class="button" href="https://www.overleaf.com/docs?snip_uri=https://github.com/hnuthesis/hnuthesis/archive/refs/heads/main.zip&engine=xelatex">在 Overleaf 中打开</a>
  <a class="button" href="https://www.overleaf.com/read/rpzgkfpfwntd#3a7618">在线阅读</a>
</div>

<div class="spread" aria-label="模板封面与源码示意">
  <div class="sheet" aria-hidden="true">
    <div class="sheet-school">湖南大学</div>
    <div class="sheet-kind">硕士学位论文</div>
    <div class="sheet-title">论文题目写在这里</div>
    <dl class="sheet-meta">
      <dt>学位申请人</dt><dd>姓名</dd>
      <dt>指导教师</dt><dd>姓名　教授</dd>
      <dt>学科专业</dt><dd>专业名称</dd>
    </dl>
  </div>
  <pre class="source"><code><span class="c">% main.tex</span>
\documentclass[<b>master</b>,<b>super</b>,<b>pdf</b>]{hnuthesis}

\input{metadata}

\begin{document}
  \include{chapters/abstract}
  \include{chapters/introduction}
  \include{chapters/conclusion}
  \printbibliography
\end{document}</code></pre>
</div>

<section class="intro-section">
  <h2>论文写作，不必从排版开始</h2>
  <dl class="plain-list">
    <dt>章节与元数据分开存放</dt>
    <dd>封面信息写在 <code>metadata.tex</code>，每章一个文件放在 <code>chapters/</code>。缺少的可选章节不会阻止编译。</dd>
    <dt>按硕士论文要求排版</dt>
    <dd>封面、摘要、目录、正文和引用格式已经配置好，不必逐项手调。</dd>
    <dt>选项只在需要时才用</dt>
    <dd>学位类型、引用方式、PDF 输出和盲审都是文档类选项，其余仍是你熟悉的 LaTeX 流程。</dd>
  </dl>
</section>

<section class="start-panel">
  <div>
    <h2>开始写作</h2>
    <p>下载模板，修改 <code>metadata.tex</code> 和 <code>chapters/</code> 里的内容，然后在项目根目录编译。需要安装 XeLaTeX 和 latexmk。</p>
  </div>
  <pre class="source"><code>$ ./run.sh</code></pre>
</section>

<section class="options-section">
  <h2>文档类选项</h2>
  <div class="option-list">
    <div><code>master</code><span>默认的硕士论文；<code>doctor</code> 会改为博士学位名称，博士规范尚未全面适配。</span></div>
    <div><code>super</code> / <code>numbers</code> / <code>authoryear</code><span>上标数字、行内数字或著者—年份引用。</span></div>
    <div><code>blind</code><span>隐藏封面上的身份信息；正文和附件中的个人信息需要另外检查。</span></div>
    <div><code>pdf</code><span>彩色链接和单面排版，适合电子版。</span></div>
  </div>
</section>

<section class="notice-panel">
  <h2>使用前请注意</h2>
  <p>这是湖南大学硕士论文模板，不是通用模板。博士版和其他学校的规范尚未全面支持，提交前请对照最新的学院要求检查。目前只生成 PDF，不提供 Word 版。</p>
  <a href="https://github.com/hnuthesis/hnuthesis#编译">阅读安装、字体和完整配置说明</a>
</section>

<footer class="site-footer">
  <span>开源项目，MIT 许可</span>
  <a href="https://github.com/hnuthesis/hnuthesis">GitHub 仓库</a>
</footer>
