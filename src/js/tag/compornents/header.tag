import RiotControl from 'riotcontrol';
import Store from '../../Store/Store';
<niltea-header>
	<header class="mainHeader">
		<h1>
			<a href="/" class="home">
				<span class="mainTitle">{title}</span>
				<span class="siteDescription"><raw content="{description}" /></span>
			</a>
		</h1>
		<nav class="gnav clearfix" id="gnav">
			<ul>
				<li class="gnav_item about" title="about"><a href="/about/" target="_top">about</a></li>
				<li class="gnav_item pixiv" title="Pixiv"><a href="http://www.pixiv.net/member.php?id={pixiv}" target="_blank">pixiv</a></li>
				<li class="gnav_item twitter lsf" title="Twitter"><a href="http://www.twitter.com/{TwitterUsername}" target="_blank">twitter</a></li>
				<li class="gnav_item github lsf" title="GitHub"><a href="https://github.com/niltea" target="_blank">github</a></li>
			</ul>
		</nav>
	</header>
	<script>
		const self = this;
		self.title = '';
		self.description = '';
		// Subscribes Store.changedBlogInfo
		RiotControl.on(Store.ActionTypes.changedBlogInfo, () => {
			const blogInfo = Store.blogInfo;
			self.title = blogInfo.title;
			self.description = blogInfo.description;
			self.update();
		});
	</script>
	<style type="text/scss">
		@import "../../../css/includes/mixin";
		.mainHeader {
			@include clearfix;
			position: fixed;
			width: 100%;
		}
		a {
			text-decoration: none;
			color: #000;
		}
		h1 {
			float: left;
			padding-left: 2%;
			a {
				display: block;
			}
			.mainTitle {
				display: block;
				font-size: 3.8em;
				line-height: 1em;
				letter-spacing: 0.05em;
			}
			.siteDescription {
				display: block;
				margin-top: 10px;
				font-weight: 400;
				font-size: 1.0em;
				line-height: 1em;
				letter-spacing: 0.15em;
			}
		}
		.gnav {
			float: left;
			padding-left: 40px;
			padding-top: 15px;
			max-width: 80%;
		}
		.gnav_item {
			display: inline-block;
			line-height: 1em;
			font-size: 2.0em;
			+ .gnav_item {
				margin-left: 1.5em;
			}
			&:first-child { margin: 0; }
			&.active,
			&:hover {
				/*border-color: #2d73a8;*/
			}
			a {
				font-size: 1em;
			}
			&.lsf a {
				font-size: 1.2em;
			}
			&.pixiv a {
				width: 18px;
				height: 18px;
				display: block;
				background: url(/images/pixiv.svg) 0 0 no-repeat;
				background-size: 100%;
				@include txtHide;
			}
		}
		@media screen and (max-width: 37.5em) {
			h1, .gnav {
				float: none;
			}
			.gnav {
				padding-left: 2%;
				padding-top: 23px;
			}
		}
	</style>
</niltea-header>