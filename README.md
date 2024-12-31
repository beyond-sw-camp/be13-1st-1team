# Kppong
<img src="profiles/logo.png" width="300" height="300"/>
<br/>
<br/>
<br/>

# 🫡팀원소개
<!-- ### 🧑‍💻김범석 [ @g00dbyul ](https://github.com/g00dbyul)
### 🧑‍💻송현준 [ @Hyeonjunnn ](https://github.com/Hyeonjunnn)
### 👩‍💻이제경 [ @jelee55 ](https://github.com/jelee55)  
### 🧑‍💻이창신 [ @always0702 ](https://github.com/always0702) -->

|<img src="profiles/mymelody.jpg" width="200" height="200"/> | <img src="profiles/mycall.png" width="200" height="200"/> |<img src="profiles/zzangu.png" width="200" height="200"/>|<img src="profiles/ddunge.png" width="200" height="200"/>|
| :------------------------------------------------------------: | :------------------------------------------------------------: |:------------------------------------------------------------: |:------------------------------------------------------------: |
|🧑‍💻김범석 [ @g00dbyul ](https://github.com/g00dbyul)|🧑‍💻송현준 [ @Hyeonjunnn ](https://github.com/Hyeonjunnn)|👩‍💻이제경 [ @jelee55 ](https://github.com/jelee55)|🧑‍💻이창신 [ @always0702 ](https://github.com/always0702)


<br/>
<br/>
<br/>


# 📣프로젝트 소개
지금 이 순간에도 한류는 퍼져나가 K-POP, K-FOOD 열풍이 끊이지 않고 있습니다. 이에 발맞추어 대한민국을 찾는 외국인들도 점점 증가하는 추세입니다. 

현재 여러 여행 상품 플랫폼들이 존재하지만 국내 관광과 좀 더 밀접한 플랫폼을 만드는 것이 주 목적입니다.

"Kppong"은 국내 관광에 최적화된 카테고리, 체험 프로그램을 소개하고 방한하는 외국인들에게 즐거운 경험이 될 수 있도록하는 선택지를 늘려줍니다. 

또한 깨끗한 커뮤니티와 진정성 있는 액티비티를 위해 관리자가 관리하고 소통 창구를 통해 사용자 간의 의사소통을 지원합니다.

## 주요 기능
* 사용자는 마음에 드는 프로그램이 있다면 '찜'이라는 항목에 저장하여 추후에도 관심있는 프로그램에 쉽게 접근할 수 있습니다.

* 사용자는 마음에 드는 판매자에게 '즐겨찾기'로 등록하여 '즐겨찾기'로 판매자들을 분류하고 판매자들의 게시물을 빠르게 확인할 수 있습니다.

* 플랫폼 내에서 불량한 내용을 가진 프로그램을 제공하는 판매자나 같이 참여하는 입장에서 불편을 끼치거나 해를 입히는 사용자에게 경고를 주어 일정 이상 경고가 누적될 경우 플랫폼에서 퇴출되어 다시 접속할 수 없도록 합니다.

* 플랫폼 내에 게시판이 존재하여 사용자가 자유롭게 게시물을 작성할 수 있으며 댓글을 통해 서로 소통하며 정보 공유나 후기 등을 공유할 수 있도록 합니다.

<br/>
<br/>
<br/>

# 📄 WBS

![WBS](https://github.com/beyond-sw-camp/be13-1st-201Successful-Kppong/blob/main/WBS.png)

<br/>
<br/>
<br/>

# 🍔 기술스택

![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![MariaDB](https://img.shields.io/badge/MariaDB-003545?style=for-the-badge&logo=mariadb&logoColor=white)

![Prometheus](https://img.shields.io/badge/Prometheus-E6522C?style=for-the-badge&logo=Prometheus&logoColor=white)
![Grafana](https://img.shields.io/badge/grafana-%23F46800.svg?style=for-the-badge&logo=grafana&logoColor=white)

![Git](https://img.shields.io/badge/git-%23F05033.svg?style=for-the-badge&logo=git&logoColor=white)
![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white)
![Discord](https://img.shields.io/badge/Discord-5865F2.svg?style=for-the-badge&logo=discord&logoColor=white)

<br/>
<br/>
<br/>


# 🍔 아키텍처
<img src="profiles/architecture.png" width="800" height="600"/> 

## 설계의도

CQRS(Command Query Responsibility Segregation)
- 데이터의 명령(Command)과 조회(Query)를 분리하는 아키텍처 패턴
- 명령 작업과 조회 작업을 독립적으로 최적화 가능

Proxysql을 통해 명령 작업은 Mater DB에 적용, 조회 작업은 Slave DB에서 조회


<br/>
<br/>
<br/>

# 요구사항 명세서
<details>
<summary> <b> 요구사항 명세서 </b> </summary>
<div markdown="1">


![요구사항 명세서](https://cdn.discordapp.com/attachments/1323349820890419314/1323350855365427360/--0.jpg?ex=67743206&is=6772e086&hm=aa7a0bb3d612d344c07294709427a2b00f6f9b4d8b96268f9978e54ee30b839f&)
![요구사항 명세서2](https://cdn.discordapp.com/attachments/1323349820890419314/1323350855830736906/--1.jpg?ex=67743206&is=6772e086&hm=64c66b5f7d407dbd770e94eb76aeed4cfb9c2c2dfb3ac3ba99cd9ffebaa10142&)


</div>
</details>

<br/>
<br/>
<br/>

# ERD 다이어그램
![erdCloud](https://cdn.discordapp.com/attachments/1323349820890419314/1323350575181598740/kppong.png?ex=677431c3&is=6772e043&hm=b0eddd83cac1a273940bff1b153c8160b8dd7ad36b34415265c76591101f9b3a&)

<br/>
<br/>
<br/>

# 테이블 명세서

<details>
<summary> <b> 테이블 명세서 </b> </summary>
<div markdown="1">

![테이블 명세서 1](https://cdn.discordapp.com/attachments/1323349820890419314/1323351149088346253/page-0001.jpg?ex=6774324c&is=6772e0cc&hm=85da5b700383b06c6f9864e2412af6f520891deac4a35347a110739b6b4b8810&)
![테이블 명세서 2](https://cdn.discordapp.com/attachments/1323349820890419314/1323351149625212928/page-0002.jpg?ex=6774324c&is=6772e0cc&hm=83ab84783c813b837044b346e34ed9f18cce717a0514132045e60f578c38e8fc&)
![테이블 명세서 3](https://cdn.discordapp.com/attachments/1323349820890419314/1323351148794478602/page-0003.jpg?ex=6774324c&is=6772e0cc&hm=4ee9c140f6ffca2755f0f771ccf7b21c73280c378cc147e50243a7aaf50f6c72&)


</div>
</details>

<br/>
<br/>
<br/>

# 프로시저 명세서

<details>
<summary> <b> 프로시저 명세서 </b> </summary>
<div markdown="1">

![프로시저 명세서1](https://cdn.discordapp.com/attachments/1323349820890419314/1323352138528587886/page-0001.jpg?ex=67743338&is=6772e1b8&hm=15cc04669d20fd5c7737d7795f4be512caff3e3923d304cddadb4751a467e34c&)
![프로시저 명세서1](https://cdn.discordapp.com/attachments/1323349820890419314/1323352138209951856/page-0003.jpg?ex=67743338&is=6772e1b8&hm=8cf09b814c8873039179d93a676e46b9d4aa2fc1dde1afe78278c3c744e89787&)

</div>
</details>

<br/>
<br/>
<br/>

# 테스트 명세서
<details>
<summary> <b> 테스트 명세서 </b> </summary>
<div markdown="1">

![테스트 명세서](https://cdn.discordapp.com/attachments/1323349820890419314/1323351683119579308/--0.jpg?ex=677432cb&is=6772e14b&hm=b3d441dc44275a67b76f0448d41edccfc082bbb861373e0087c1e5d386b95f7c&)
![테스트 명세서2](https://cdn.discordapp.com/attachments/1323349820890419314/1323351682423455774/--1.jpg?ex=677432cb&is=6772e14b&hm=4026f6c8844cf4b6dfb61663539502da15fde14f68b379ad23c533173c40e37e&)


</div>
</details>

<br/>
<br/>
<br/>


# SQL

<details>
<summary> <b> user </b> </summary>
<div markdown="1">

- 회원가입
```
DELIMITER $$
CREATE OR REPLACE PROCEDURE insertUser(
    IN _userId VARCHAR(15),
       `_name` VARCHAR(15),
       _email VARCHAR(40),
       _passwd VARCHAR(40),
       _nickname VARCHAR(15),
       _phoneNum VARCHAR(15),
       _birthAt DATE,
       _national VARCHAR(15)
       )
BEGIN
    -- 회원 아이디 중복 방지 조건문
    DECLARE _cnt INT;
	SET _cnt = (SELECT COUNT(*) 
                FROM user 
                WHERE userId = _userId
                   OR email = _email
                   OR phoneNum = _phoneNum
                );

    IF (
        _cnt < 1 
    )THEN
            INSERT INTO user (
                userId,
                `name`,
                email,
                passwd,
                nickName,
                phoneNum,
                birthAt,
                national,
                updatedAt
                )
            VALUES (
                _userId,
                `_name`,
                _email,
                _passwd,
                _nickname,
                _phoneNum,
                _birthAt,
                _national,
                NULL
                )
            ;
    ELSE
        SELECT '이미 존재하는 회원 정보입니다.';
            
    END IF;

END $$
DELIMITER ;
```
<img src="profiles/insertUser_result.png"/>

- 로그인
```
DELIMITER $$
CREATE OR REPLACE PROCEDURE loginByUserId_passwd(
    IN _userId VARCHAR(15),
       _passwd VARCHAR(40)
    )
BEGIN

	DECLARE _cnt INT;
	SET _cnt = (SELECT COUNT(*) 
                FROM user 
                WHERE userId = _userId
      				AND passwd = _passwd
                );

    IF (
        _cnt >= 1 
    )
    THEN
    	SELECT '로그인 성공';
    ELSE 
   	    SELECT '로그인 실패';
    END IF;
END $$
DELIMITER ;
```
<img src="profiles/loginSuccess_result.png"/>
<img src="profiles/loginFail_result.png"/>

- 개인정보 수정
```
DELIMITER $$
CREATE OR REPLACE PROCEDURE updateOneUser_passwdByUserId(
    IN _userId VARCHAR(15),
       _passwd VARCHAR(40),
       _updatePasswd VARCHAR(40)
    )
BEGIN
    DECLARE _cnt INT;
	SET _cnt = (SELECT COUNT(*) 
                FROM user 
                WHERE userId = _userId
                  AND passwd = _passwd);

    IF (
        _cnt >= 1 
    )THEN
        UPDATE user 
        SET passwd = _updatePasswd
        WHERE (userId = _userId
          AND passwd = _passwd);
    ELSE
        SELECT '아이디 또는 비밀번호를 확인해주세요' AS '인증 오류';
    END IF;

END $$
DELIMITER ;
```
<img src="profiles/updateOneUser_result.png"/>


</div>
</details>

<details>
<summary> <b> package </b> </summary>
<div markdown="1">

- 패키지 등록
  
![패키지 등록](https://cdn.discordapp.com/attachments/1318411133933060198/1323466906409238569/54127955c02bf0b4.png?ex=67749e1b&is=67734c9b&hm=9e97e5f80f2225e205c34998a5f1a010b8c010eab6d89976ae92b1ad4e2b5dcb&)

- 조회

![](https://cdn.discordapp.com/attachments/1318411133933060198/1323466906887258182/66ec93d136cf09c6.png?ex=67749e1b&is=67734c9b&hm=ab73075825f69221a1f88aa3e21ba5df12f47c39e550eaf0c72cb919daa36fec&)


- 결과값

![결과값](https://cdn.discordapp.com/attachments/1318411133933060198/1323468186149978214/image.png?ex=67749f4c&is=67734dcc&hm=48515012d49721051145ce218097793296ac08cfb6a076f104b9e6e15534f24f&)
</div>
</details>

<details>
<summary> <b> order </b> </summary>
<div markdown="1">

- 등록
  
![등록](https://cdn.discordapp.com/attachments/1318411133933060198/1323466882803695657/a7f921b98fa5c7ca.png?ex=67749e15&is=67734c95&hm=74eb74be48d850c41fbcba248608697fe99d32915942c291133f703b29816d05&)

- 조회
  
![조회](https://cdn.discordapp.com/attachments/1318411133933060198/1323466883181187093/804a6277e97536aa.png?ex=67749e15&is=67734c95&hm=f53e06ff1c3e634821056eea9402136b4d4e039e232e42138df486ab2fb01131&)

- 결과값

![결과](https://cdn.discordapp.com/attachments/1318411133933060198/1323466882451505242/a097c5f83aa56bc3.png?ex=67749e15&is=67734c95&hm=071b92118d011b51a158b327f7bdc65b552c8a6c6788358f73099344fe3f6993&)

- 에러(진행중인 패기지가 아니면 발생)
  
![에러](https://cdn.discordapp.com/attachments/1318411133933060198/1323466906069635163/c0ac644b0baebeb0.png?ex=67749e1b&is=67734c9b&hm=134ff5eed7fe9db73e2076ee4b9735fd02f4956f1803253695eb0ce32c87eb73&)


</div>
</details>




<br/>
<br/>
<br/>

