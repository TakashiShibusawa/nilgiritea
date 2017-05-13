import RiotControl from 'riotcontrol';

import Store from '../Store/Store';
<niltea-post>
	<div class="post post-single">
		<!-- Photo -->
		<div class="photo" if={photos}>

			<a class="photo_item photo_item-single" if={!isPhotoSet} each={photos} href='{original_size.url}'>
				<img src="{alt_sizes[0].url}" alt="">
			</a>
			<a class="photo_item photo_item-set" if={isPhotoSet} each={photos} href='{original_size.url}'>
				<img src="{alt_sizes[0].url}" alt="">
			</a>
		</div>
		<span>{caption}</span>
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
		];
		self.isPhotoSet = false;

		self.on('unmount', () => {
			RiotControl.off(Store.ActionTypes.changed);
		});

		// Subscribes Store.onChanged
		RiotControl.on(Store.ActionTypes.changed, () => {
			const content = Store.content[0];
			console.log(content)
			contentKeys.forEach(key => { self[key] = content[key] });
			// photosが複数であればphososetであると判断
			self.isPhotoSet = (self.photos.length > 1);
			self.update();
		});

	</script>
</niltea-post>