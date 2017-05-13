import route from 'riot-route';
import RiotControl from 'riotcontrol';

import Action from '../Action/Action';
import Store from '../Store/Store';

<niltea-index>

	<section id="article_list" class='article_list'>
		<niltea-list-item articleList={articleList}></niltea-list-item>
	</section>
	<script>
		const self = this;
		self.articleList = {};

		// Subscribes Store.onChanged
		RiotControl.on(Store.ActionTypes.changed, () => {
			self.articleList = Store.content;
			riot.update();
		});

		self.on('mount', () => {
		});

		self.on('unmount', () => {
			RiotControl.off(Store.ActionTypes.changed);
		});
	</script>
</niltea-index>

<niltea-list-item>
	<article each={item in opts.articlelist} class='article-list_item'>
		<a class="photo" href='{original_size.url}' if={item.photos} each={item.photos}>
			{console.log(original_size)}
			<!-- <img src="{original_size.url}" alt=""> -->
			<img src="{alt_sizes[4] ? alt_sizes[4].url : alt_sizes[3].url}" alt="">
		</a>
		<h3 class='title'>{item.title}</h3>
		href='/articles/{item.id}'
	</article>
	<script>
		const self = this;
		self.on('update', () => {console.log(opts.articlelist)})
	</script>

</niltea-list-item>

<niltea-index-list-lead>
	<span class='line' each={content in lines}>{content}</span>
	<script>
		let content = opts.content;
		content = content.replace('</p>', '').replace('<p>', '');
		this.lines = content.split('<br />');
	</script>
</niltea-index-list-lead>