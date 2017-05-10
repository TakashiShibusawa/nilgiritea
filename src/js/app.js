// import utility
import util from './niltea_util.js';

// riot and tags
require('riot');
require('./tag/Index.tag')

const RiotControl  = require('riotcontrol');

document.addEventListener('DOMContentLoaded', () => {
	riot.mount('#wrapper', 'niltea-page');
});



// $(function(){
// 	var $container = $('.postContainer');
// 	var $post = $container.children('.post').first();
// 	var isPermaLink = ($post.hasClass('permaLink'))? true : false;
// 	if(isPermaLink === false){
// 		$container.imagesLoaded(function(){
// 			$container.masonry({
// 				itemSelector: '.post',
// 				columnWidth: 290,
// 				gutter: 30
// 			});
// 		});
// 		// photosetResize();
// 	}
// });
// Photoset Resize Code by Kevin - EXCOLO.TUMBLR.COM 
// function photosetResize() {
// 	$('iframe.photoset').each(function(){
// 		var newSize = 290;
// 		var newSrc = $(this).attr('src').replace('500',newSize);
// 		$(this).attr('src', newSrc).width(newSize);
// 		var high = $(this).css('height');
// 		var calculate = parseInt(high, 10)* newSize/500;
// 		$(this).css('height', calculate);
// 	});
// }
