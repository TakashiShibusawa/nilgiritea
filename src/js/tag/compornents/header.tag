import RiotControl from 'riotcontrol';
import Store from '../../Store/Store';
<niltea-header>
	<header class="mainHeader">
		<h1 class="pageTitle">
			<a href="/" class="home">{title}</a>
			<span class="description"></span>
		</h1>
		<nav class="gnav clearfix" id="gnav">
			<ul>
				<li class="gnav_item about" title="about"><a href="/#/about/" target="_top">about</a></li>
				<li class="gnav_item blog" title="blog"><a href="/#/" target="_top">blog</a></li>
				<li class="gnav_item twitter" title="twitter"><a href="http://www.twitter.com/{TwitterUsername}" target="_blank">twitter</a></li>
				<li class="gnav_item pixiv" title="pixiv"><a href="http://www.pixiv.net/member.php?id={pixiv}" target="_blank">pixiv</a></li>
				<li class="gnav_item github" title="github"><a href="https://github.com/niltea" target="_blank">GitHub</a></li>
			</ul>
		</nav>
	</header>
	<script>
		const self = this;
		// Subscribes Store.changedBlogInfo
		RiotControl.on(Store.ActionTypes.changedBlogInfo, () => {
			const content = Store.blogInfo;
			// console.log(content)
			self.title = content.title;
			self.update();
		});
	</script>
	<style type="text/scss">
		@import "../../../css/includes/mixin";
		a {
			text-decoration: none;
			color: #000;
		}
		.mainHeader {
			padding-top: 30px;
			@include clearfix;
		}
		.pageTitle {
			float: left;
			a {
				font-size: 2.8em;
			}
		}
		.gnav {
			float: left;
			margin-left: 40px;
		}
		.gnav_item {
			display: inline-block;
			/*border-bottom: 3px solid #303233;*/
			+ .gnav_item {
				margin-left: 30px;
			}
			&:first-child { margin: 0; }
			&.active,
			&:hover {
				/*border-color: #2d73a8;*/
			}
			a {
				font-size: 1.8em;
			}
		}
	</style>
</niltea-header>