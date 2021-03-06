import 'riot';
import route from 'riot-route';
import RiotControl from 'riotcontrol';

import Action from '../Action/Action';
import Store from '../Store/Store';
import Constant from "../Constant/Constant";

<niltea-base>
	<section class='header' ref='header'></section>
	<section class='content' ref='content'></section>
	<section class='footer' ref='footer'></section>
	<section class='nilteamodal' ref='nilteamodal'></section>
	<section class='loader' ref='loader'></section>
	<script>
		const self = this;
	window.addEventListener('scroll', Action.onScroll);

	self.on('mount', () => {
		riot.mount(self.refs.header, 'niltea-header');
		riot.mount(self.refs.footer, 'niltea-footer');
		riot.mount(self.refs.loader, 'niltea-loader');
	});

	// routing
	route.base('/');
	// indexで取得する記事数
	const limit = Constant.indexPostLimit;
	// Indexのロード
	route('/', () => {
		riot.mount(self.refs.content, 'niltea-index');
		Action.loadContent({type: 'posts', query: {limit}, current: 'index', page: 1}).then(() => {
		});
	});
	// index / pagenation
	route('/index/*', (page) => {
		riot.mount(self.refs.content, 'niltea-index');
		Action.loadContent({type: 'posts', query: {limit, offset: limit * (page - 1)}, current: 'index', page});
	});

	// post
	route('/post/*', (id) => {
		riot.mount(self.refs.content, 'niltea-post');
		riot.mount(self.refs.nilteamodal, 'niltea-modal');
		Action.loadContent({type: 'posts', query: {id}, current: 'posts'});
	});

	// about
	route('/about', () => {
		riot.mount(self.refs.content, 'niltea-about')
		const hasInfo = !!Store.blogInfo;
		Action.loadContent({type: 'info', hasInfo, current: 'about'});
	});

	// default
	route('*', () => {route('/')});
	route.start(true);

</script>
</niltea-base>