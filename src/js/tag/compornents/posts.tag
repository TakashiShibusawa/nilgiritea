<niltea-posts>
	<li class="post {block:Text}text {/block:Text}{block:Photoset}photoset {/block:Photoset}{block:Photo}photo {/block:Photo}{block:RebloggedFrom}reblogged {/block:RebloggedFrom}{block:Quote}quote {/block:Quote}{block:Link}link {/block:Link}{block:Chat}chat {/block:Chat}{block:Audio}audio {/block:Audio}{block:Video}video {/block:Video}{block:Answer}answer {/block:Answer}{block:Date}not-page post-{PostID}{/block:Date} {block:PermalinkPage} active permaLink{/block:PermalinkPage}">
		<div class="content">
			{block:Photoset}
			<!-- Photoset -->
			<div class="photoContainer">
				{block:IndexPage}{block:Photos}<a href="{Permalink}"><img src="{PhotoURL-400}" alt="{PhotoAlt}" /></a>{/block:Photos}{/block:IndexPage}
				{block:PermalinkPage}{block:Photos}<a href="{Permalink}"><img src="{PhotoURL-HighRes}" alt="{PhotoAlt}" /></a>{/block:Photos}{/block:PermalinkPage}
			</div>
			{block:Caption}{Caption}{/block:Caption}
			{/block:Photoset}{block:Link}
			<!-- Link -->
			{block:Thumbnail}
			<div class="link-thumbnail"><img src="{Thumbnail-HighRes}" alt="" /></div>
			{/block:Thumbnail}
			<h2 class="post_title"><a href="{URL}" {Target}>{Name} <span></span></a></h2>
			{block:Description}{Description}{/block:Description}
			{/block:Link}{block:Text}
			<!-- Text -->
			{block:Title}<h2 class="post_title">{Title}</h2>{/block:Title}
			<div class="textContent">
				{Body}{block:More}
				<small><a href="{Permalink}">{lang:Read more}</a></small>{/block:More}
			</div>
			{/block:Text}{block:Quote}
			<!-- Quote -->
			<blockquote class="{Length}">{Quote}</blockquote>{block:Source}<div class="source">{Source}</div>{/block:Source}
			{/block:Quote}{block:Chat}
			<!-- Chat -->
			{block:Title}<h2 class="title"><a href="{Permalink}">{Title}</a></h2>{/block:Title}
			<ul class="conversation">
				{block:Lines}
				<li class="chat-{Alt}">{block:Label}<span class="label">{Label}</span>{/block:Label} {Line}</li>
				{/block:Lines}
			</ul>
			{/block:Chat}
		</div>
		<!-- //content -->
		{block:HasTags}<div class="tags clearfix">{block:Tags}<a href="{TagURL}"><span>#</span>{Tag}&nbsp;</a>{/block:Tags}</div>{/block:HasTags}
		<div class="meta clearfix">
			<div class="dateNote">
				<a href="{Permalink}">{block:Date}{ShortMonth} {DayOfMonth}{DayOfMonthSuffix}, {Year}</a>{/block:Date}{block:IfShowNotes}{block:NoteCount}<br /><a href="{Permalink}#notes">{NoteCountWithLabel}</a>{/block:NoteCount}{/block:IfShowNotes}
			</div>{block:Date}
			<ul class="postControls">
				<li><a href="https://twitter.com/intent/tweet?text={URLEncodedTweetSummary}" class="tweet_button" target="_blank"><i class="fa fa-twitter"></i></a></li>
				<li>{ReblogButton size="25" color="black"}</li>
				<li>{LikeButton size="25" color="black"}</li>
			</ul>{/block:Date}
		</div>
		<!-- //<meta> -->
	</li>
	{block:IfShowNotes}<li class="notesContainer">{PostNotes}</li>{/block:IfShowNotes}
</niltea-posts>