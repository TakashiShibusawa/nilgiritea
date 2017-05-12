import TumblrActionCreators from '../actions/tumblr-action-creators.js';

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