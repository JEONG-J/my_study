
# my Swift Study - Chapter14[옵셔널 체이닝과 빠른종료]

## 옵셔널 체이닝
    ● 옵셔널에 속해 있는 nil일지도 모르는 프로퍼티, 메서드, 서브스크립션 등을 가져오거나 호출할 때 사용할 수 있는 일련의 과정
    ● 옵셔널을 반복 사용하요 옵셔널이 자전거 체인처럼 서로 꼬리를 물고 있는 모양이기 떄문에 옵셔널 체이닝 이라고 한다.
    ● 중첩된 옵셔널 중 하나라도 값이 존재하지 않는다면 결과적으로 nil을 반환한다.
    ● 옵셔널이 nil이 아니라면 정상적으로 호출, nil이라면 결괏값으로 nil 반환

+ 옵셔널 느낌표(!)<br>
옵셔널에 값을 추출해 반환하기 때문에 반환 값이 옵셔널이 아니다!!

> <b>사람의 주소 정보 표현 설계
```SWift
    class Room{
        var number: Int //방 번호

        init(number: Int){
            self.number = number
        }
    }

    class Building{
        var name: String //건물 이름
        var room: Room? //건물의 방 정보

      init(name: String){
          self.name = name
      }
    }

    struct Address{ //주소
        var province: String //지역 광역시/도
        var city: String //지역 시/군/구
        var street: String //도로명
        var building: Building? //
        var detailAddress: String? //건물 외 상세 주소
    }

    class Person{
        var name: String
        var address: Address?

        init(name: String){
            self.name = name
        }
    }

    let myInstance: Person = Person(name: "my")

    let myRoomViaOptionalChaining: Int? = my.address?.building?.room?.number
    print(myRoomViaOptionalChaining) //nil
```

> <b>옵셔널 바인딩 사용
```Swift
    class Room{
        var number: Int //방 번호

        init(number: Int){
            self.number = number
        }
    }

    class Building{
        var name: String //건물 이름
        var room: Room? //건물의 방 정보

      init(name: String){
          self.name = name
      }
    }

    struct Address{ //주소
        var province: String //지역 광역시/도
        var city: String //지역 시/군/구
        var street: String //도로명
        var building: Building? //
        var detailAddress: String? //건물 외 상세 주소
    }

    class Person{
        var name: String
        var address: Address?

        init(name: String){
            self.name = name
        }
    }

    let myInstance: Person = Person(name: "my")
    var roomNumber: Int? = nil
    if let myAddress: Address = myInstance.address{
        if let myBuilding: Building = myAddress.building{
            if let myRoom: Room = myBuilding.room{
                roomNumber = myRoom.number
            }
        }
    }

    if let number: Int = roomNumber{
        print(number)
    } else{
        print("not room number")
    }
```

> <b>옵셔널 체이닝 사용
```Swift
    class Room{
        var number: Int //방 번호

        init(number: Int){
            self.number = number
        }
    }

    class Building{
        var name: String //건물 이름
        var room: Room? //건물의 방 정보

      init(name: String){
          self.name = name
      }
    }

    struct Address{ //주소
        var province: String //지역 광역시/도
        var city: String //지역 시/군/구
        var street: String //도로명
        var building: Building? //
        var detailAddress: String? //건물 외 상세 주소
    }

    class Person{
        var name: String
        var address: Address?

        init(name: String){
            self.name = name
        }
    }

    let myInstance: Person = Person(name: "my")

    if let roomNumber: Int = myInstance.address?.building?.room?.number{
        print(roomNumber) //nil
    } else{
        print("not room Number)
    }
```

> <b>옵셔널 체이닝을 통한 값 할당 시도
```Swift
    class Room{
        var number: Int //방 번호

        init(number: Int){
            self.number = number
        }
    }

    class Building{
        var name: String //건물 이름
        var room: Room? //건물의 방 정보

      init(name: String){
          self.name = name
      }
    }

    struct Address{ //주소
        var province: String //지역 광역시/도
        var city: String //지역 시/군/구
        var street: String //도로명
        var building: Building? //
        var detailAddress: String? //건물 외 상세 주소
    }

    class Person{
        var name: String
        var address: Address?

        init(name: String){
            self.name = name
        }
    }

    let myInstance: Person = Person(name: "my")
    myInstance.address?.building?.room?.number = 505
    print(myInstance.address?.building?.room?.number) //nil
    //이유 : address 프로퍼티가 없으므로 그 하위 프로퍼티도 없다

    myInstance.address = Address(province: "충북", city: "청주시", street: "충청대로", building: nil, detailAddress: nil)
    myInstance.address?.building = Building(name: "타워")
    myInstance.address?.building?.room = Room(number: 0)
    myInstance.address?.building?.room?.number = 505

    print(myInstance.address?.building?.room?.number) //Optional(505)
```
> 옵셔널 체이닝을 통한 메서드 호출
```Swift
    struct Address{
        var province: String
        var city: String
        var street: String
        var building: Building?
        var detailAddress: String?

        init(province: String, city: String, street: String){
            self.province = province
            self.city = city
            self.street = street
        }

        func fullAddress() -> String{
            var restAddress: String? = nil

            if let buildingInfo: Building = self.building{

                restAddress = buildingInfor.name
            } else if let detail = self.detailAddress{
                restAddress = detail
                }
            
        }
    }
```

---
야곰 지음 - 스위프트 프로그래밍3판을 공부하고 작성하였음
---