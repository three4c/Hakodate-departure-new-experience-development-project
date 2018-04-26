int val4 ;
int val5 ;

// 電源起動時とリセットの時だけのみ処理される(初期化と設定処理)
void setup() {
  Serial.begin(9600) ;                    // 9600bpsでシリアル通信のポートを開きます
}
// 繰り返し実行される処理(メインの処理)
void loop() {
  val4 = analogRead(A3)  ;
  val5 = analogRead(A4)  ;

 
 if (val4 > 350) {
    Serial.write(4);
    delay(500);
  } else if (val5 > 350) {
    Serial.write(5);
    delay(500);
  }else {
    Serial.write(0);
  }
  
 
  Serial.print(val4);
  Serial.print(" ");
  Serial.println(val5);
  delay(500);
  
}

