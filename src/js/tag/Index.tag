import RiotControl from 'riotcontrol';

import Action from '../Action/Action';
import Store from '../Store/Store';
<niltea-index>
	<section id="article_list" class='post'>
		<niltea-list-item articleList={articleList}></niltea-list-item>
	</section>
	<script>
		const self = this;
		self.articleList = {};

		// Subscribes Store.onChanged
		RiotControl.on(Store.ActionTypes.changed, () => {
			self.articleList = Store.content;
			self.update();
		});

		self.on('updated', Action.setLoader );
		self.on('before-mount', Action.showLoader );
		self.on('mount', () => {
		});

		self.on('unmount', () => {
			RiotControl.off(Store.ActionTypes.changed);
		});
	</script>
</niltea-index>

<niltea-list-item>
	<article each={item in opts.articlelist} style='background-image: url({item.photos ? item.photos[0].original_size.url : null});' class='post_item loader_bgi'>
		<a class="post_item_link" href='/post/{item.id}'>
			<div class="post_item_info">
				<h3 class='post_item_title'><raw content={item.title} /></h3>
				<section class="post_item_meta">
					<span class="post_item_date">{this.formatDate(item.date)}</span>
					<span class="post_item_notes">66 notes</span>
				</section>
			</div>
		</a>
	</article>
	<script>
		const self = this;
		self.on('update', () => {console.log(opts.articlelist)});
		self.formatDate = date => {
			const _date = new Date(date);
			return `${_date.getFullYear()} / ${_date.getMonth() + 1} / ${_date.getDate()}`;
		}
	</script>
	<style type="text/scss">
		.post_item {
			will-change: filter;
			width: 100%;
			height: 350px;
			margin: 15px auto 0;
			background: #888 center center no-repeat;
			background-size: cover;
			transition: filter 0.4s;
			&:hover {
				transition: filter 0.2s;
				filter: brightness(1.1);
			}
			&:first-child { margin-top: 0; }
		}
		.post_item_link {
			display: block;
			width: 100%;
			height: 100%;
			box-sizing: border-box;
			padding: 25px;
			text-decoration: none;
			color: #000;
		}
		.post_item_info {
			width: 100%;
			height: 100%;
			box-sizing: border-box;
			border: 5px solid #000;
			border-radius: 2px;
			background-color: rgba(#fff, 0.6);
			display: flex;
			flex-direction: column;
			justify-content: flex-end;
			padding: 15px;
		}
		.post_item_date,
		.post_item_notes {
			display: block;
		}
		.post_item_title {
			font-size: 2.6em;
		}
		.post_item_date {
			font-size: 1.6em;
		}
		.post_item_notes {
			font-size: 1.0em;
		}

	</style>
</niltea-list-item>

<niltea-index-list-lead>
	<span class='line' each={content in lines}>{content}</span>
	<script>
		let content = opts.content;
		content = content.replace('</p>', '').replace('<p>', '');
		this.lines = content.split('<br />');
	</script>
</niltea-index-list-lead>