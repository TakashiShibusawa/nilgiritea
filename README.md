# nilgiri-tea

## なにこれ
[・◡・]< [nilgiri-tea.net](http://nilgiri-tea.net)用Tumblrテーマを書き換えよう計画。  
とりあえずriot.js使ってみようプランで書き換え中。  
環境は[この辺](http://qiita.com/yaaah93/items/071a1c573eb763212e48)参考に。
コード周りはReactだけど[この辺](http://qiita.com/monpy/items/b6ebe9bc77b3ad0ffade)を見つつ。


## いまここ
[・◡・]< 動作周りもうちょっと実装詰めていこうね。スタイル調整もだけど。

## これから
[・◡・]< 形にはなってきてる。  

### 動作
[・◡・]< 実装詰めつつバグも取りつつ。  

タイトル変わるようになったけどmetaタグも。  

Likeの動作が依然わからず

個別ページ取得するAPIがない  
→ひとまずtag分けたけどどうしよう、ベタ書きかな…？  
内容修正の度にロジック触る事になるのでナンセンス感はある。

最終的にはAWS S3あたりで動かす感じに……？  

モーダル、前後画像に移動できるようにする…？

### デザイン
[・◡・]< 大枠では良いんだけどもうちょっとこう。  

適当にエフェクトとか。

ハンバーガーメニュー付けたけど、アクセス時はメニュー表示させたままの方が良いかも。。  
スクロールで消すとか。

ロゴとか差し替える

## 作業ログ
### 5/21/2017
クロスオリジンでJSON取ってこられないのどうしたら良いんだろうと思ってたのだけど、JSONP使えばいいんじゃんってオチでした。  
ばっかでー。

infiniteScroll：/index/2 を表示した時延々ページのロードを続けてしまうやつ治した。
modalが正常表示されないのも治った。イベント殺してないだけだった。  

モーダルまわり調整しつつ、記事画像は見切れないようレイアウト調整処理入れた。

### 5/20/2017  
routingとともにタイトルが変わるように
→loadContentで呼ぶようにした  
SPハンバーガーメニュー実装

### 5/18/2017  
ページネーション、表示されないしまあスタイル周りはいいか……。  
折角実装したけどクローラー以外使ってくれない機能になるのかな。。  
infiniteScrollいちおう実装したけど上述の通りバグあり。

TOPの見た目は一旦fix。あと細部詰め。  
あとこのドキュメントに手を入れたりした。

### 5/14/2017  
#### ローダー
付けた。
#### ページネーション
リンク表示周りがちょっと手間掛かった。たぶん大丈夫？  
offsetの実装はリンク表示さえ組めればクッソ楽だった。  

#### post(photoset)
ひとまずpostの画像が出るぐらいのところまではやった。  
想像通り、photosetクッソめんどくさい…  
強引な書き方したのでもうちょいなんとかしたい。  
画像の縦横サイズ取って比率計算→親要素の幅から高さ計算……？（面倒くさい）

[ナナシスを聴いてください](https://www.youtube.com/watch?v=HnkmzmivO7I)