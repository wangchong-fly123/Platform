<div>
<nav id="menu" class="navbar navbar-default navbar-fixed-top">
  <div class="container"> 
    <div class="navbar-header">
      <div class="navbar-brand">
        <div id="logo"></div>
      </div>
      <p class="navbar-text">欢动科技</p>
    </div>
    <div class="collapse navbar-collapse">
      <ul class="nav navbar-nav navbar-right">
        <li><a href="{{ url('/') }}">首页</a></li>
        <li><a href="{{ url('/company_intro') }}">简介</a></li>
        <li><a href="{{ url('/game_intro') }}">游戏</a></li>
        <li><a href="{{ url('/join_us') }}">加入</a></li>
        <li><a href="{{ url('/contact_us') }}">联系</a></li>
      </ul>
    </div>
  </div>
</nav>
{{ content() }}
<nav id="footer">
  <div class="container">
    <div class="fnav text-center">
      <p>Copyright &copy; 2015 上海欢动科技有限公司 | 沪ICP备14041413号-1</p>
    </div>
  </div>
</nav>
</div>
