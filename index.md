---
layout: default
title: HNU Thesis
description: 湖南大学学位论文 LaTeX 模板 · 专注规范排版，让写作回归内容
---

<p class="eyebrow">HUNAN UNIVERSITY · LATEX THESIS TEMPLATE</p>

# 把时间留给研究，<br>让排版回归规范。

为湖南大学学位论文准备的 XeLaTeX 模板。清晰的章节结构、开箱即用的排版和可组合的文档选项，让你从一份整洁的论文工程开始。

<div class="hero-actions">
  <a class="button button-primary" href="https://github.com/yusanshi/hnuthesis/releases/latest">获取最新版本 <span aria-hidden="true">↗</span></a>
  <a class="button button-secondary" href="https://www.overleaf.com/read/rpzgkfpfwntd#3a7618">在线预览 <span aria-hidden="true">↗</span></a>
</div>

<p class="hero-note">硕士论文默认样式 · XeLaTeX 编译 · MIT License</p>

<section class="intro-section">
  <p class="section-kicker">A BETTER STARTING POINT</p>
  <h2>论文写作，不必从排版开始</h2>
  <p class="section-lead">从封面信息到章节组织，常用结构已经准备好。专注你的研究内容，再按学院要求核对最终格式。</p>

  <div class="feature-grid">
    <article class="feature-card">
      <span class="card-number">01 / STRUCTURE</span>
      <h3>清晰的论文结构</h3>
      <p>元数据、章节、参考文献各自独立。按需替换示例内容，缺少的可选章节也不会阻塞编译。</p>
    </article>
    <article class="feature-card">
      <span class="card-number">02 / TYPOGRAPHY</span>
      <h3>面向规范的排版</h3>
      <p>针对湖南大学硕士论文组织封面、摘要、目录、正文与引用格式，减少重复的版式配置。</p>
    </article>
    <article class="feature-card">
      <span class="card-number">03 / FLEXIBLE</span>
      <h3>需要时再做选择</h3>
      <p>提供学位类型、引用方式、PDF 输出和盲审选项；保留熟悉的 LaTeX 工作流。</p>
    </article>
  </div>
</section>

<section class="start-panel">
  <div>
    <p class="section-kicker">GET STARTED</p>
    <h2>几步开始你的论文</h2>
    <p>下载模板，编辑 <code>metadata.tex</code> 与 <code>chapters/</code>，然后编译生成 PDF。</p>
  </div>
  <div class="command-block">
    <span class="command-label">在项目根目录运行</span>
    <code>./run.sh</code>
    <span class="command-hint">需要 XeLaTeX 与 latexmk</span>
  </div>
</section>

<section class="options-section">
  <p class="section-kicker">MADE TO BE CONFIGURED</p>
  <h2>从默认配置开始，按需调整</h2>
  <div class="option-list">
    <div><code>master</code><span>默认硕士论文；<code>doctor</code> 切换学位名称（博士规范尚未全面适配）。</span></div>
    <div><code>super</code> / <code>numbers</code> / <code>authoryear</code><span>上标数字、行内数字或著者—年份引用。</span></div>
    <div><code>blind</code><span>隐藏封面上的身份信息；请另外检查正文和附件中的个人信息。</span></div>
    <div><code>pdf</code><span>彩色链接与单面排版，适用于电子版输出。</span></div>
  </div>
</section>

<section class="notice-panel">
  <span class="notice-icon" aria-hidden="true">i</span>
  <div>
    <h2>使用前请留意</h2>
    <p>这是湖南大学硕士论文模板，不是跨学校通用模板。博士版和其他学校的排版规范尚未全面支持；提交前请对照最新校院要求检查。当前构建只生成 PDF，不包含 Word 版转换。</p>
    <a href="https://github.com/yusanshi/hnuthesis#编译">查看安装、字体和完整配置说明 <span aria-hidden="true">→</span></a>
  </div>
</section>

<footer class="site-footer">
  <span>开源项目 · MIT License</span>
  <a href="https://github.com/yusanshi/hnuthesis">在 GitHub 上查看项目 <span aria-hidden="true">↗</span></a>
</footer>
