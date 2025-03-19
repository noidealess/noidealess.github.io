---
layout: '[layout]'
title: 再论虚化
date: 2025-03-12 21:32:49
tags:
---
# 理论推导：表观虚化
我们有薄透镜成像公式
$$
\frac{1}{s'}=\frac{1}{f}+\frac{1}{s}\tag{1}
$$
以及像距物距公式
$$
s'=f(1-m),\quad s=f\left( \frac{1}{m}-1 \right), \tag{2}
$$
其中 $s, s', f, m$分别为物距、像距、焦距、放大倍率。
现考虑一物距为 $s$，位于光轴上的物点 $P$。设薄透镜有效口径为 $D$，则由几何关系可以算出经过薄透镜边缘的光线在像方空间的斜率 $k'$ 为
$$
k'= \frac{D}{2s'}=\frac{D}{2 f(1-m)}=\frac{F}{2(1-m)}. \tag{3}
$$
其中 $F=\frac{f}{D}$ 为光圈值。
当镜头对准物距为 $s_{0}$ 的物体对焦时，此时焦平面位于像距
$$
s_{0}'=\frac{1}{f}+\frac{1}{s_{0}} \tag{4}
$$
处。设另一像点 $P'$ 的物距为 $s_{0}+\Delta$ 处，其中 $\Delta \in (-s_{0},+\infty)$. 这一像点成像在
$$
s_{\Delta}'=\frac{1}{f}+\frac{1}{s_{0}+\Delta} \tag{5}
$$
处。由公式(4)(5)，$P'$ 发出的经过透镜边缘的光线在焦平面上的截距为
$$
\begin{aligned}\tag{6}
y_{\Delta}&= k'_{\Delta}(s_{\Delta}'-s_{0}') \\
&= \frac{D}{2\left( \frac{1}{f}+\frac{1}{s_{0}} \right)}\left( \frac{1}{s_{0}+\Delta}-\frac{1}{s_{0}}\right) \\
&=\frac{Dfs_{0}}{2(s_{0}+f)} \frac{-\Delta}{s_{0}(s_{0}+\Delta)} \\
&=-\frac{Df\Delta}{2(s_{0}+f)(s_{0}+\Delta)}
\end{aligned}
$$
而 $|y_{\Delta}|$ 即为 $P'$ 在焦平面上所成的弥散圆半径。设传感器容纳的最大像高为 $H$，则此时的虚化量 $B_{1}$ 可以定义为
$$
\begin{aligned}\tag{7}
B_{1}&\equiv \frac{|y_{\Delta}|}{H} \\
&=\left|\frac{Df\Delta}{2H(s_{0}+f)(s_{0}+\Delta)}\right| \\ 
&= \left|\frac{f^2\Delta}{2FH(s_{0}+f)(s_{0}+\Delta)}\right|\\
&=\left|\frac{Df\Delta}{2H\left[ f\left( \frac{1}{m}-1 \right)+f \right]\left[ f\left( \frac{1}{m}-1 \right)+\Delta \right]}\right|  \\
&=\left|\frac{Dm\Delta}{2H\left[ f\left( \frac{1}{m}-1 \right)+\Delta \right]}\right|.
\end{aligned}
$$
我们不妨称 $B_{1}$ 为*表观虚化量*。下面我们分析不同情况影响表观虚化量的因素。
## 相同物距
首先讨论物距 $s_{0}$ 相同的情况。这对应于现实生活中拍摄位置由于客观限制无法改变的情况，例如生态摄影、体育摄影。
### 光圈影响
由(7)的第三行，$B_{1}$ 随 $\frac{1}{F}$ 线性变化。因此，光圈变大一档，对应于光圈值 $F$ 变为原来的 $\frac{1}{\sqrt{ 2 }}$ 倍，此时表观虚化量变为原来的 $\sqrt{ 2 }$ 倍。
### 焦距影响
对于一般摄影而言，物距总是远大于焦距（即此处不考虑微距摄影的情况）。我们取近似 $s_{0}\gg f$，则(7)式化为
$$
B_{1}=\left| \frac{f^2 \Delta}{2FHs_{0}(s_{0}+\Delta)} \right|=\left| \frac{fD \Delta}{2Hs_{0}(s_{0}+\Delta)} \right|.
$$
- 如果保持光圈值 $F$ 不变，增大焦距 $f$，则表观虚化量随 *焦距的平方* 增长；
- 如果保持透镜口径 $D$ 不变，增大焦距 $f$，则表观虚化量随 *焦距线性* 增长，对应于加增倍镜的情况。
### 背景距离影响
下面讨论近景虚化（$\Delta\to 0^+$）以及远景虚化（$\Delta\to \infty$）两种情况。
#### 近景虚化
近景虚化能力，即对于对焦点附近的物体的虚化能力。如果近景虚化能力强，则对应于该镜头的景深很浅，相应地对于对焦精度的要求就更大。在日常使用中人们往往将景深和虚化能力混为一谈，这是不准确的。下面我们将通过计算说明，近景虚化和远景虚化取决于不同的要素。
我们对 $B_{1}$ 关于 $\Delta$ 求偏导数：
$$
\begin{aligned}
\frac{\partial}{\partial\Delta}B_{1}&= \frac{2f^2FH(s_{0}+f)(s_{0}+\Delta)-2f^2FH(s_{0}+f)\Delta}{4F^2H^2(s_{0}+f)^2(s_{0}+\Delta)^2} \\
&=\frac{2f^2FH(s_{0}+f)s_{0}}{4F^2H^2(s_{0}+f)^2(s_{0}+\Delta)^2} \\
&=\frac{s_{0}}{2FH(s_{0}+f)(s_{0}+\Delta)^2}.
\end{aligned}
$$
取近景条件 $\Delta\to 0$ 以及近似 $s_{0}\gg f$，则
$$
\frac{\partial}{\partial\Delta}B_{1} \to \frac{s_{0}}{2FH(s_{0}+f)}\approx \frac{1}{2FH}.
$$
即近景表观虚化仅仅取决于光圈和画幅大小。光圈越大、画幅越小，则近景虚化能力越大。这里关于画幅的结论可能违反一般关于画幅越大景深越浅的直觉，这里给出一个图像上的解释。画幅减小的过程相当于在后期将画面裁切放大，因此同样的弥散圆，可能在较大画幅上看不出明显虚化，而裁切放大以后就显得模糊。
#### 远景虚化
令背景无限远，即 $\Delta\to \infty$，有
$$
B_{1}\to \frac{f^2}{2FH (s_{0}+f)} \approx \frac{f^2}{2F Hs_{0}}= \frac{fD}{2Hs_{0}}
$$
即在物距不变的情况下，远景虚化能力取决于 $\frac{f^2}{F}$ 或 $fD$。可以看到，这里 *焦距* 起了至关重要的作用。在镜头口径不变的情况下，增加焦距（例如使用增倍镜，或选择同口径但焦距更长的镜头）能够 *线性增加* 远景虚化量。例如在鸟类摄影中，在同一个位置使用 $400\text{mm}, f/2.8$ 镜头的远景虚化效果就不如 $800\text{mm}, f/5.6$ 的镜头。
## 相同画面比例
如果我们控制主体在画面中所占的比例相同，即对于同一焦平面上的主体，我们控制 $\frac{h'}{H}$ 相同，其中 $h'$ 为像高。当 $\frac{h'}{H}$ 相同时，这意味着
$$
\frac{h'}{H}=\frac{mh}{H}=\frac{s_{0}'h}{s_{0}H}
$$
应保持相同。拍摄同一被摄体时，物高 $h$ 总是一定的。这意味着我们只需要控制
$$
\lambda\equiv \frac{s_{0}'}{s_{0}H}=\frac{m}{H}
$$
这对应于大部分的日常摄影情况。例如我们想拍摄一个人物的半身照，希望比较不同镜头对于这同一摄影主题的虚化表现时，相同画面比例的虚化就更有参考意义。由(7)最后一个等号可推得
$$
\begin{aligned}
B_{1}&=\left|\frac{Dm\Delta}{2H\left[ f\left( \frac{1}{m}-1 \right)+\Delta \right]}\right|\\
&=\left|\frac{D\lambda\Delta}{2f\left( \frac{1}{H \lambda}-1 \right)+\Delta }\right|.
\end{aligned}
$$
### 焦距影响
控制主体比例、镜头口径相同时，不难发现
### 背景距离影响
#### 近景虚化
$$
\begin{aligned}
\frac{\partial}{\partial \Delta}B_{1}&= \frac{D\lambda \left[ 2f\left( \frac{1}{H \lambda}-1 \right)+\Delta \right]-D\lambda \Delta}{\left[ 2f\left( \frac{1}{H \lambda}-1 \right)+\Delta \right]^2} \\
&=\frac{2fD\lambda \left( \frac{1}{H\lambda}-1 \right)}{\left[ 2f\left( \frac{1}{H \lambda}-1 \right)+\Delta \right]^2}.
\end{aligned}
$$
当 $\Delta=0$ 时有
$$
\frac{\partial}{\partial \Delta}B_{1}=\frac{D}{2f\left( \frac{1}{H\lambda}-1 \right)}=\frac{1}{2F \left( \frac{1}{H\lambda}-1 \right)}.
$$
因此在主体比例、画幅大小保持不变的情况下，近景虚化也只取决于光圈。
#### 远景虚化
当 $\Delta\to \infty$时，有
$$
B_{1}\to \lambda D.
$$
说明控制同一主体画面比例时，镜头的表观虚化量大小仅仅取决于镜头的入瞳直径。