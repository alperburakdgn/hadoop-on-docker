# 🧪 YARN + HDFS Entegrasyonu Test Senaryosu 2: Büyük WordCount İşlemi

Bu senaryoda daha büyük bir metin dosyası üzerinde WordCount MapReduce job'u çalıştırılacak. Amaç, HDFS’e büyük bir input dosyası yükleyip, YARN üzerinden işleyip çıktıyı yine HDFS’e yazmak ve sistemi uçtan uca doğrulamaktır.

---

## 🎯 Senaryo Özeti

- 📥 Girdi: Büyük bir `.txt` dosyası (örnek: `sample_text.txt`)
- 🔄 Yürütme: Hadoop WordCount örneği
- 📤 Çıktı: `/big-output` klasörüne HDFS içinde yazılacak

---

## 📁 1. Test verisini oluştur ve HDFS'e yükle

### 🔹 1.1. Metin dosyasını oluştur (örnek cümle çoğaltmalı)

```bash
yes "Lorem ipsum dolor sit amet consectetur adipiscing elit." | head -n 10000 > sample_text.txt
```

> Bu komut aynı satırı 10.000 kez yazar.

### 🔹 1.2. Dosyayı container’a kopyala

```bash
docker cp sample_text.txt namenode:/home/hadoop/
```

### 🔹 1.3. HDFS’e yükle

```bash
docker exec -it namenode hdfs dfs -mkdir -p /big-input
docker exec -it namenode hdfs dfs -put /home/hadoop/sample_text.txt /big-input
```

---

## 🚀 2. WordCount job'unu başlat

```bash
docker exec -it resourcemanager bash
```

Container içinde:

```bash
hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-*.jar wordcount /big-input /big-output
```

---

## ✅ 3. Çıktıyı kontrol et

```bash
docker exec -it namenode hdfs dfs -ls /big-output
docker exec -it namenode hdfs dfs -cat /big-output/part-r-00000 | head -n 20
```

Örnek çıktı:
```
Lorem       10000
ipsum       10000
dolor       10000
...
```

---

## 💡 Bu test neyi gösterir?

- YARN job’larının HDFS’ten büyük veri okuyabildiğini
- Tüm iş parçacıklarının başarılı şekilde çalıştığını
- Çıktının HDFS'e doğru yazıldığını

Bu test sistemin sağlamlığını pratik olarak ispatlar.