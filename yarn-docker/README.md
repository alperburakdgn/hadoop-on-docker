# 🧠 Hadoop + YARN Dağıtık Sistem Kurulumu (Docker Tabanlı)

Bu projede, Docker Compose kullanılarak HDFS ve YARN bileşenlerinden oluşan bir büyük veri altyapısı ayağa kaldırılmıştır.

## 📁 Klasör Yapısı

```
.
├── hadoop-docker/         # HDFS (NameNode + 2 DataNode)
│   ├── Dockerfile
│   ├── docker-compose.yml
│   └── config/
│       ├── core-site.xml
│       └── hdfs-site.xml
│
└── yarn-docker/           # YARN (ResourceManager + 2 NodeManager + JobHistoryServer)
    ├── Dockerfile
    ├── docker-compose.yml
    └── config/
        ├── core-site.xml
        ├── yarn-site.xml
        └── mapred-site.xml
```

---

## 🧱 1. Ortak Ağ Kurulumu

Tüm container’ların birbirini görebilmesi için öncelikle Docker ağı oluşturulur:

```bash
docker network create hadoop-net
```

Bu ağ her iki `docker-compose.yml` içinde şöyle tanımlanmalıdır:

```yaml
networks:
  hadoop-net:
    external: true
```

---

## 🚀 2. Başlatma Sırası

### 1. HDFS'yi başlat

```bash
cd hadoop-docker
docker compose up -d
```

### 2. YARN'ı başlat

```bash
cd ../yarn-docker
docker compose up -d --build
```

---

## ✅ Başarıyı Kontrol Etme

### 🔹 NameNode Web UI

```
http://localhost:9870
```

### 🔹 YARN ResourceManager UI

```
http://localhost:8089
```

> YARN UI’de “**Active Nodes: 2**” görmelisin.

### 🔹 JobHistory Server UI

```
http://localhost:19889
```

---

## 🧪 Test Komutları

HDFS durumu:

```bash
docker exec -it namenode hdfs dfsadmin -report
```

YARN Node listesi:

```bash
docker exec -it resourcemanager yarn node -list
```

---

## 💡 Ek Bilgiler

- Dockerfile’larda `hadoop` kullanıcısı üzerinden çalışılır.
- Tüm bileşenler aynı `hadoop-net` ağına bağlı olmalıdır.
- Config dosyalarındaki `fs.defaultFS` ve `resourcemanager.hostname` gibi ayarlar hostname’lerle uyumlu olmalıdır.

---

## ✨ Hazırlayan

Bu yapılandırma, tutarlı, modüler ve üretime yakın bir ortamda büyük veri uygulamaları geliştirmek isteyenler için örnek teşkil etmektedir.  
Herhangi bir katkı veya geliştirme önerisi için PR gönderebilirsiniz. ❤️