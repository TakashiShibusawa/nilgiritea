import riot from 'riot';
import route from 'riot-route';

import Action from '../Action/Action';
import Store from '../Store/Store';
import RiotControl from 'riotcontrol';

<niltea-base>
	<section class='header' ref='header'></section>
	<section class='content' ref='content'></section>
	<section class='footer' ref='footer'></section>
	<script>
		const self = this;

	self.on('mount', () => {
		riot.mount(self.refs.header, 'niltea-header');
		riot.mount(self.refs.footer, 'niltea-footer');
	});


	// routing
	route.base('/');

	// Indexのロード
	route('/', () => {
		riot.mount(self.refs.content, 'niltea-index')
		Action.loadContent({type: 'posts'});
		// document.title = `${Store.blogInfo.title}`;
		Action.setCurrent({current: 'index', page: 1});
	});

	// post
	route('/post/*', (id) => {
		riot.mount(self.refs.content, 'niltea-post');
		Action.loadContent({type: 'posts', query: {id}});
		Action.setCurrent({current: 'posts', id});
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