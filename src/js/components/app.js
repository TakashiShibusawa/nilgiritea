import TumblrActionCreators from '../actions/tumblr-action-creators.js';

const API_KEY = "Rak7GXrKPBB6uuTODOgQL3hPLpnTAf2b2IoUjAUoBd8yLoCthg";
const BASE_URL = "http://api.tumblr.com/v2/blog/nilgiritea.tumblr.com/posts";

export default {
  // get some message
  // set offset and can get 20 article

  getArticleFromOffset: function(offset = 0) {
    let url = BASE_URL + '?api_key=' + API_KEY + '&offset=' + offset;
    fetch(url).then(res => {
      console.log(err, res);
      var blogInfo = res.response.blog;
      var articles = res.response.posts;
      // blog の情報 , articles(Array) を送る
      TumblrActionCreators.addArticle(blogInfo, articles, offset);
    });
  }
 
}