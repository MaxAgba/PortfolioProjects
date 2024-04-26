Select *
From [CellPhone_test 1]

Select *
From [CellPhone_train 1]


Select MAX(test.battery_power) AS highestbatterypower, test.blue, train.price_range
From [CellPhone_test 1] test
INNER JOIN [CellPhone_train 1] train
ON test.id = train.id
WHERE test.blue <> '0' AND train.price_range <> '0'
GROUP BY test.blue, train.price_range
ORDER BY highestbatterypower


Select  test.touch_screen, train.price_range, COUNT(test.touch_screen) AS NumberofTOUCHSCREEN
From [CellPhone_test 1] test
INNER JOIN [CellPhone_train 1] train
ON test.id = train.id
WHERE test.touch_screen <> '0' AND train.price_range <> '0'
GROUP BY test.touch_screen, train.price_range


Select  test.touch_screen, train.price_range, COUNT(test.touch_screen) AS NumberofTOUCHSCREEN
From [CellPhone_test 1] test
INNER JOIN [CellPhone_train 1] train
ON test.id = train.id
WHERE test.touch_screen = '0' AND train.price_range <> '0'
GROUP BY test.touch_screen, train.price_range


Select  test.four_g, train.price_range, COUNT(test.four_g) AS FOURGPRICEINFLUENCE
From [CellPhone_test 1] test
INNER JOIN [CellPhone_train 1] train
ON test.id = train.id
WHERE test.four_g <> '0' AND train.price_range <> '0'
GROUP BY test.four_g, train.price_range


Select  test.four_g, train.price_range, COUNT(test.four_g) AS FOURGPRICEINFLUENCE
From [CellPhone_test 1] test
INNER JOIN [CellPhone_train 1] train
ON test.id = train.id
WHERE test.four_g = '0' AND train.price_range <> '0'
GROUP BY test.four_g, train.price_range

DROP Table if exists #PHONEWITHWIFIPRICE
Create Table #PHONEWITHWIFIPRICE
(
wifi int,
price_range int,
Phonewithwifi int
)
INSERT INTO #PHONEWITHWIFIPRICE
Select  test.wifi, train.price_range, COUNT(test.wifi) AS PHONEWITHWIFI
From [CellPhone_test 1] test
INNER JOIN [CellPhone_train 1] train
ON test.id = train.id
WHERE test.wifi <> '0' AND train.price_range <> '0'
GROUP BY test.wifi, train.price_range

Select *
From #PHONEWITHWIFIPRICE




DROP Table if exists #PHONEWITHOUTWIFIPRICE
Create Table #PHONEWITHOUTWIFIPRICE
(
wifi int,
price_range int,
Phonewithwifi int
)
INSERT INTO #PHONEWITHOUTWIFIPRICE
Select  test.wifi, train.price_range, COUNT(test.wifi) AS PHONEWITHWIFI
From [CellPhone_test 1] test
INNER JOIN [CellPhone_train 1] train
ON test.id = train.id
WHERE test.wifi = '0' AND train.price_range <> '0'
GROUP BY test.wifi, train.price_range

Select *
From #PHONEWITHOUTWIFIPRICE


WITH PRICEVSCLOCKSPEED (Clock_speed, price_range, CL0CKSPEEDPHONEPRICE) AS
(
Select  test.clock_speed, train.price_range, COUNT(test.clock_speed) AS CL0CKSPEEDPHONEPRICE
From [CellPhone_test 1] test
INNER JOIN [CellPhone_train 1] train
ON test.id = train.id
WHERE test.clock_speed <>'0' AND train.price_range <> '0'
GROUP BY test.clock_speed, train.price_range
)

Select MAX(clock_speed) AS MAXCLOCKSPEED, price_range,CL0CKSPEEDPHONEPRICE
FROM PRICEVSCLOCKSPEED
GROUP BY price_range, CL0CKSPEEDPHONEPRICE
ORDER BY MAXCLOCKSPEED DESC


CREATE PROCEDURE TALKTIME
AS
Select  test.clock_speed,test.talk_time, train.price_range, COUNT(test.clock_speed) AS CL0CKSPEEDPHONEPRICE
From [CellPhone_test 1] test
INNER JOIN [CellPhone_train 1] train
ON test.id = train.id
WHERE test.clock_speed <>'0' AND train.price_range <> '0' AND test.talk_time > '7'
GROUP BY test.clock_speed,test.talk_time, train.price_range


EXEC TALKTIME