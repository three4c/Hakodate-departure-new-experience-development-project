int val1 ;
int val2 ;
int val3 ;

// 電源起動時とリセットの時だけのみ処理される(初期化と設定処理)
void setup() {
  Serial.begin(9600) ;                    // 9600bpsでシリアル通信のポートを開きます
}
// 繰り返し実行される処理(メインの処理)
void loop() {
  val1 = analogRead(A0)  ;                     // センサーから読み込む
  val2 = analogRead(A1)  ;
  val3 = analogRead(A2)  ;

  
  if (val1 > 350) {
    Serial.write(1);
    delay(500);
  } else if (val2 > 350) {
    Serial.write(2);
    delay(500);
  } else if (val3 > 350) {
    Serial.write(3);
    delay(500);
  }else {
    Serial.write(0);
  }
 
  
  Serial.print(val1);
  Serial.print(" ");
  Serial.print(val2);
  Serial.print(" ");
  Serial.println(val3);
  Serial.println(" ");
  delay(500);
  
  
}

