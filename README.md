# 食用方法
## 要使用noidealess愉快地创作，需要按照步骤部署
1.打开[nodejs](https://nodejs.org/en/download)，选择系统并下载安装，windows系统推荐下载msi包自动配置，不建议使用命令行；  
2.打开终端，输入`node -v``npm -v`（分别输入），显示版本号即可；  
3.打开[git](https://git-scm.com/downloads)，选择系统并下载安装，中途直接下一步即可；  
4.打开系统属性，配置系统变量，点击Path并编辑，添加git和nodejs的exe文件夹地址（无需精确到exe文件）；  
5.在git bash中输入`ssh-keygen -t rsa -C "xxx@xxx.com"  // 将 "xxx@xxx.com" 替换为你自己GitHub的邮箱地址`  
输入`cd ~/.ssh``cat id_rsa.pub`，打开GitHub点击头像进入settings，打开SSH and GPG keys，并点击New SSH key，粘贴刚刚复制的内容，回到git bash输入`ssh -T git@github.com`出现successfully即可；  
6.在你要部署noidealess的文件夹处右键并打开git bash，输入`git clone https://github.com/noidealess/noidealess.github.io.git`即可；  
7.下载完成后，输入以下命令`npm install hexo``npm install``npm install hexo-deployer-git`（无需输入hexo init）；  
8.输入`hexo clean &&hexo g&&hexo s`即可在本地访问你的noidealess（可供调试使用）；  
9.输入`hexo new [layout] 标题`可以自动在/source/_post创建文档，其中与标题同名的文件夹是资源文件夹，如需调用图片，请输入`![](某某.jpg)`；  
10.调试完成后输入`hexo d`可以提交更新网页；  
11.提交后请输入`git add .``git commit -m "v几点几  //版本号，规范为v2025.3.14，若当天更新超过一版，则变为v2025.3.14.1或更后"``git push origin hexo`与github同步进度。  
如有问题请先尝试重启，无法解决请联系群u。  
若有ssh:connect to host github.com port 22:Connection refused，请查看[https://zhuanlan.zhihu.com/p/521340971]  
ssh-key问题，请查看[https://zhuanlan.zhihu.com/p/688103044]  
