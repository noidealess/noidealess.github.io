const Home = window.location.pathname === '/';
const OtherPage = window.location.pathname.includes('/about/') || window.location.pathname.includes('/archives/') || window.location.pathname.includes('/categories/') || window.location.pathname.includes('/tags/') || window.location.pathname.includes('/about/');
if (banner && (Home || OtherPage)) {
const imgs = [
	"/global/banner/sysu100.jpg",
	"/global/banner/1.jpg",
	"/global/banner/2.jpg",
	"/global/banner/3.jpg",
	"/global/banner/4.jpg",
	"/global/banner/5.jpg",
]
const luck_img = imgs[Math.floor(Math.random() * imgs.length)]
const banner = document.getElementById('banner')
banner.style.background = `url(${luck_img}) center center / cover no-repeat`
}