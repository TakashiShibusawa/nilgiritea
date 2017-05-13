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
		Action.loadContent('posts');
		Action.setCurrent({current: 'index'});
	});

	// post
	route('/post/*', (postID) => {
		riot.mount(self.refs.content, 'niltea-post');
		Action.loadContent('posts', postID);
		Action.setCurrent({current: 'posts', postID});
	});

	// default
	route('*', () => {route('/')});
	route.start(true);

</script>
</niltea-base>