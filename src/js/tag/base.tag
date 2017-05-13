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
		document.title = 'Nilgiri Tea'
		Action.loadContent({type: 'posts'});
		Action.setCurrent({current: 'index'});
	});

	// post
	route('/post/*', (postID) => {
		riot.mount(self.refs.content, 'niltea-post');
		Action.loadContent({type: 'posts', postID});
		Action.setCurrent({current: 'posts', postID});
	});
	// about
	route('/about', () => {
		riot.mount(self.refs.content, 'niltea-about')
		const info = Store.blogInfo;
		if (!info) Action.loadContent({type: 'posts', limit: 1});
		document.title = 'about | Nilgiri Tea'
		// Action.loadContent('posts');
		Action.setCurrent({current: 'about'});
	});

	// default
	// route('*', () => {route('/')});
	route.start(true);

</script>
</niltea-base>