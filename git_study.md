# 깃 허브 공부 기록!!
공부이유
------
깃을 공부함으로써 개발자로서 필요한 역량 함양 또한 공부한 내용을 기록하고 참고할 수 있기 때문이다.

-----

+ 깃 설치
	```git
	brew install git
	```
+ 저장소 만들기
	```git
	폴더생성
	git init => .git 생성(버전 정보 포함)
	```
+ 버전 관리
	```git
	파일 생성
	git status => 저장소 확인
	git add => 버전 관리 시작
	```
+ 버전 생성 (✻ 작업이 완결된 상태)
	```git
	git config --global user.name "xxx"
	git config --global user.email "xxx"
	git add "file_name" => stage aread 상태로 만들기
	git commit
	```
	> 간략하게 커밋하기
	git commit -am "메시지"
+ 변경 사항 확인하기
	```git
	git log -p => ++ : 최신 커밋 정보, -- : 이전 커밋 정보
	git log "commit id" => 커밋 id 이전의 메시지만 확인
	git diff "commit id 1".."commit id2"
	git diff => 서로 비교하며 어떤 작업했는지 확인
	```
+ git 과거로 가기
	```git
	git reset "commit id" --hard => 커밋 id에 해당하는 버전으로 돌아가기
	git revert "commit id" => 커밋 id 취소하면서 새롭게 생성
	```
+ git의 원리<br>
	<img src="https://img1.daumcdn.net/thumb/R1280x0.fpng/?fname=http://t1.daumcdn.net/brunch/service/user/3K6t/image/_630fSrZQJj7XdswACSoCGDI1vE.png" with=100>

>head 파일 생성 -> master 파일 -> 최신 커밋 가리킨다.

>branch 생성 -> refs/heads/branch 이름
+ branch
<br>
<img src = "https://media.vlpt.us/images/chillihc/post/c77d4d85-f479-40bc-ba4b-82be8d09fc98/1e5d7590562b3b214008617211b2539ce2bddfaf.png">
	```git
	git branch => 기본 브랜치 master
	git branch "name" => 브랜치 생성
	git checkout "name" => 브랜치 변경
	git log --branches --decorate --graph --oneline => branch의 로그를 한 줄 상태로 쉽게 확인
	git log -p "name1".."name2" => 두 브랜치 차이점 확인
	```
+ branch 병합
	```git
	git merge "name" => "name"을 master로 병합
	git branch -d "name" => "name" 브랜치 삭제
	```
+ stash((✻ add는 되고, commit 하지 않는 내용 숨기기)
	```git
	git stash save => 작업 내용 저장
	git stash apply => 작업 내용 불러오기
	git stash list => stash 목록 보기
	git stash drop => 가장 최신 stash 삭제
	git pop => 적용하고 동시에 삭제
	```
+ reset/checkout 차이
	```git
	reset 후 master의 최신 커밋 변경 변경
	checkout "commit id" 후 -> head는 커밋 id를 가리킨다.
	```
+ soft, mixed, hard

	<img src="https://s3-ap-northeast-2.amazonaws.com/opentutorials-user-file/module/2676/5131.png">

			  |  	내용1   |    내용2    |   내용 3  |
			  |  	a      |    b       |     c	   |
			
	> soft의 경우 c만 reset

	> mixed의 경우 b,c만 reset

	> hard의 경우 a,b,c, reset

+ 3 way merge
	<img src="https://s3-ap-northeast-2.amazonaws.com/opentutorials-user-file/module/2676/5133.png">
	
        3 way merge는 base를 참고하여 수정한 사람것을 채택한다.
        그래서 효율성이 높다.

+ pull vs fetch
	+ pull
		```
		원격 저장소로부터 필요한 파일을 다운
		origin/master와 같은 위치 가리킴
		```
	+ fetch
		```
		원격 저장소로부터 필요한 파일을 다운
		origin/master는 최신 커밋을 가리킨다.
		```

+ tag
	```git
	git tag "name" "branch name"
	git tag -a "name" -m "message"
	git tag -v "name"
	git push -u --tags => 원격 저장소에 tag 등록
	git tag -d "name" => tag 삭제
	```
---
## 후기
앞으로 공부할 내용을 깃에 올리며 기록하고, 또한 프로젝트를 깃으로 관리할 필요를 느껴 공부 및 프로젝트 시작 전 깃에 대해 익히고 작성을 해봤다. 깃 사용법에 대해 어느 정도 익숙해졌지만 백문이 불여일견!!! 한 번 내용을 공부했으니 실제로 해보면서 더 알아가고 사용에 더욱 익숙해질 것이다.

---