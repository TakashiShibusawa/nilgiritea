import riot from 'riot';
import route from 'riot-route';
import RiotControl from 'riotcontrol';

import Action from '../Action/Action';
import Store from '../Store/Store';
import Constant from "../Constant/Constant";

<niltea-base>
	<section class='header' ref='header'></section>
	<section class='content' ref='content'></section>
	<section class='footer' ref='footer'></section>
	<section class='modal' ref='modal'></section>
	<section class='loader' ref='loader'></section>
	<script>
		const self = this;

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
		// document.title = `${Store.blogInfo.title}`;
		Action.setCurrent({current: 'index', page: 1});
	});
	// index / pagenation
	route('/index/*', (page) => {
		riot.mount(self.refs.content, 'niltea-index');
		Action.loadContent({type: 'posts', query: {limit, offset: limit * (page - 1), current: 'index', page}});
		// document.title = `${Store.blogInfo.title}`;
		Action.setCurrent({current: 'index', page: page});
	});

	// post
	route('/post/*', (id) => {
		riot.mount(self.refs.content, 'niltea-post');
		riot.mount(self.refs.modal, 'niltea-modal');
		Action.setCurrent({current: 'posts', id});
		Action.loadContent({type: 'posts', query: {id}, current: 'posts'});
	});

	// about
	route('/about', () => {
		riot.mount(self.refs.content, 'niltea-about')
		if (!Store.blogInfo) Action.loadContent({type: 'info'});
		// document.title = `about | ${Store.blogInfo.title}`;
		Action.setCurrent({current: 'about'});
	});

	// default
	route('*', () => {route('/')});
	route.start(true);

</script>
</niltea-base>