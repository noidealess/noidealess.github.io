hexo.extend.filter.register('theme_inject', function(injects) {
  injects.bodyEnd.raw(
    'busuanzi_script', 
    '<script src="//cdn.busuanzi.cc/busuanzi/3.6.9/busuanzi.min.js" defer></script>'
  );
  var footerHtml = `
    <div style="font-size: 0.95rem; color: #858585; margin-top: -2px; text-align: center;">
      <div id="busuanzi_container_site_pv">
        本站总访问量 <span id="busuanzi_site_pv">加载中...</span> 次
    </div>
      <div id="busuanzi_container_site_uv">
        本站总访客数 <span id="busuanzi_site_uv">加载中...</span> 人
    </div>
  `;
  injects.footer.raw('busuanzi_footer', footerHtml);
});