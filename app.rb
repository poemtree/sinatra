require "sinatra"
require "sinatra/reloader"
require "rest-client"
require "json"
require "httparty"
require "nokogiri"
require "uri"
require "date"
require "csv"

before do
    p "============================================"
    p params
    p "============================================"
end

get '/' do
   'Hello world! welcome!!!' 
end

get '/htmlfile' do
    send_file 'views/htmlfile.html'
end

get '/htmltag' do
    '<h1>html태그를 보낼 수 있습니다.</h1>
    <ul>
        <li>1</li>
        <li>2</li>
    </ul>'
end

get '/welcome/:name' do
    "Welome #{params[:name]}! Hear is PoemTree Blog!"
end

get '/cube/:num' do
    "#{params[:num].to_i**3}"
end

get '/erbfile' do
    @name = "Young PoemTree"
    erb :erbfile
end

get '/dinner-array' do
    # 메뉴들을 배열에 저장한다.
    # 하나를 추첨한다.
    # erb 파일에 담아서 랜더링한다.
    @dinner = ["샌드위치", "김밥", "케이크", "국밥", "돈까스", "햄버거"].sample
    erb :dinner
end

get '/dinner-hash' do
    # 메뉴들이 저장된 배열을 만든다.
    # 메뉴 이름(key) 사진 url(value)를 가진 hash를 만든다
    # 랜덤으로 하나를 출력한다.
    # 이름과 url을 넘겨서 erb를 랜더링 한다.
    array = ["sandwich", "gimbab", "cake"]
    hash = {:sandwich => "https://images.eatsmarter.com/sites/default/files/styles/max_size/public/double-stacked-sandwich-with-salami-and-camembert-520220.jpg", :gimbab => "https://i.pinimg.com/originals/e4/7a/f9/e47af9556a990c59701478c0fe982ca7.jpg", :cake => "https://assets.bonappetit.com/photos/59c924dc32e4b84f5a9e437a/16:9/w_1200,c_limit/1017%2520WEB%2520WEEK1060.jpg"}
    @dinner = array.sample
    @dinnerimg = hash[array.sample.to_sym]
    erb :dinnerhash
end

get '/randomgame/:name' do
    array = ["이상해씨", "파이리", "꼬부기", "피카츄", "고라파덕"]
    hash = {"이상해씨" => "https://ncache.ilbe.com/files/attach/new/20150803/377678/569613677/6317036203/5f3fcdb3e4036599540d72925632d9e9.jpg", "꼬부기" => "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIXuVkIlabTSpZhs8YDnuJjAtUaNYEqZDeOoKyiQ_KldeT_3NK", "파이리" => "data:image/png;base64,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", "피카츄" => "http://img.sbs.co.kr/newsnet/etv/upload/2013/04/07/30000259831_700.jpg", "고라파덕" => "http://image.chosun.com/sitedata/image/201402/04/2014020403444_0.jpg"}
    @name = params[:name]
    @result = array.sample
    @img = hash[@result]
    erb :randomgame
end

get '/lotto-sample' do
    
    #@lotto = (1..45).to_a.sample(6).sort
    @lotto = [1, 2, 15, 17, 23, 39]
    # rest-client를 사용하여 로또 당첨번호 받아오기
    url = "http://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo=809"
    @lotto_info =  RestClient.get(url)
    
    # 제이슨으로 파싱..
    @lotto_hash =  JSON.parse(@lotto_info)
    
    #
    @array = Array.new
    @bnus = nil
    @lotto_hash.each do |k, v|
        if k.include?("drwtNo")
            @array << v
        elsif k.include?("bnusNo")
            @bnus = v
        end
    end
    @matchNum = (@lotto&@array).length
    
    # 등수 매기기..
    # if문으로 작성 시..
    if @matchNum==6
        @rank=1
    elsif @matchNum > 2
        @rank = 8-@matchNum-(@lotto.include?(@bnus)?@matchNum/5:0)
    else
        @rank = '꽝'
    end
    
    # case 문으로 작성 시..
    @result = 
    case [@matchNum, @lotto.include?(@bnus)]
    when [6,false] then "1등"
    when [5,true] then "2등"
    when [5,false] then "3등"
    when [4,false] then "4등"
    when [3,false] then "5등"
    else "꽝"
    end
                        
    erb :lotto
end

get '/form' do
    erb :form
end

get '/search' do
    @keyword = params[:keyword]
    redirect "https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=1&ie=utf8&query=<%=@keyword%>"
end

get '/opgg' do
    erb :opgg
end

get '/opggresult' do
    uri = "http://www.op.gg/summoner/userName="
    @userName = params[:userName]
    
    # 한글 인코딩
    @encodeName = URI.encode(@userName)
    
    @res = HTTParty.get(uri+@encodeName)
    @doc = Nokogiri::HTML(@res.body)
    
    @win = @doc.css("#SummonerLayoutContent > div.tabItem.Content.SummonerLayoutContent.summonerLayout-summary > div.SideContent > div.TierBox.Box > div.SummonerRatingMedium > div.TierRankInfo > div.TierInfo > span.WinLose > span.wins").text
    @lose = @doc.css("#SummonerLayoutContent > div.tabItem.Content.SummonerLayoutContent.summonerLayout-summary > div.SideContent > div.TierBox.Box > div.SummonerRatingMedium > div.TierRankInfo > div.TierInfo > span.WinLose > span.losses").text
    @rank = @doc.css("#SummonerLayoutContent > div.tabItem.Content.SummonerLayoutContent.summonerLayout-summary > div.SideContent > div.TierBox.Box > div.SummonerRatingMedium > div.TierRankInfo > div.TierRank > span").text
    
    # File로 출력하기
    File.open('opgg.txt', 'w') do |f|
        f.write("#{@userName} : #{@win}, #{@lose}, #{@rank}\n")
    end
 
    # CSV로 출력하기
    CSV.open('opgg.csv', 'a+') do |c|
        c << [@userName, @win, @lose, @rank]
    end
    
    erb :opggresult
    
end