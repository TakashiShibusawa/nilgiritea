<niltea-photo>
	{block:Photo}
	<!-- Photo -->
	<div class="photoContainer">
		{block:IndexPage}<a href="{Permalink}"><img src="{PhotoURL-400}" alt="{PhotoAlt}" /></a>{/block:IndexPage}
		{block:PermalinkPage}{LinkOpenTag}<img src="{PhotoURL-HighRes}" alt="{PhotoAlt}" />{LinkCloseTag}{/block:PermalinkPage}
	</div>
	{block:Caption}{Caption}{/block:Caption}
	{/block:Photo}
</niltea-photo>