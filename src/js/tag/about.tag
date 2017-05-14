import RiotControl from 'riotcontrol';

import Action from '../Action/Action';
import Store from '../Store/Store';

<niltea-about>
	<section id="about" class='post page'>
		<h2 class="post_title">about page</h2>
	
	</section>
	<script>
		const self = this;
		self.on('updated', Action.setLoader );
		self.on('mount', Action.setLoader );
		self.on('before-mount', Action.showLoader );
	</script>
</niltea-about>