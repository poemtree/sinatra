require "sinatra"
require "sinatra/reloader"

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