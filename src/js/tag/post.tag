import RiotControl from 'riotcontrol';

import Store from '../Store/Store';
<niltea-post>
	<div class="post post-single">
		<h2 class="post_title">{title}</h2>
		<!-- Photo -->
		<div class="photo" if={photos}>

			<a class="photo_item photo_item-single" if={!isPhotoSet} each={photos} href='{original_size.url}'>
				<img src="{alt_sizes[0].url}" alt="">
			</a>
			<a class="photo_item photo_item-set" if={isPhotoSet} each={photos} href='{original_size.url}'>
				<img src="{alt_sizes[0].url}" alt="">
			</a>
		</div>
		<span><raw content='{caption}' /></span>
		<a href="http://tumblr.com/reblog/{id}/{reblog_key}/" class="rblg" target='_blank'>reblog</a>
	</div>

	<script>
		const self = this;
		const contentKeys = [
			'id',
			'caption',
			'title',
			'date',
			'type',
			'url',
			'photos',
			'photoset_layout',
			'reblog_key',
		];
		self.isPhotoSet = false;

		self.on('unmount', () => {
			RiotControl.off(Store.ActionTypes.changed);
		});

		// Subscribes Store.onChanged
		RiotControl.on(Store.ActionTypes.changed, () => {
			const content = Store.content[0];
			contentKeys.forEach(key => { self[key] = content[key] });
			this.caption = this.caption.replace(/<h2>(?:[a-zA-Z/d々〇〻ぁ-んァ-ヶー\u3400-\u9FFF\uF900-\uFAFF]|[\uD840-\uD87F][\uDC00-\uDFFF])+<\/h2>/, '')

			// photosが複数であればphososetであると判断
			self.isPhotoSet = (self.photos.length > 1);
			self.update();
		});

	</script>
</niltea-post>