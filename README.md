# Sinatra study

### 0. Version
- ruby : 2.4.0

### 1. Sinatra
- `mkdir sinatra-test`
    -  시나트라 파일들을 저장 할 폴더 생성
-  `cd sinatra-test`
    -  시나트라 폴더로 이동
-  `touch app.rb`
    -  루비 코드를 작성할 app.rb 파일 생성
- `gem install 'sinatra'`
    - 시나트라 젬 설치

  
```ruby
# app.rb
require 'sinatra'
get '/' do
    "Hello world!!"
end

```

- `ruby app.rb -o $IP`
    - 외부 접속 허용을 위해 IP를 변경하여 서버 실행