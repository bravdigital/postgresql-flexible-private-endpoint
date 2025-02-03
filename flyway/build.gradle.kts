buildscript {
	dependencies {
		classpath("org.flywaydb:flyway-database-postgresql:11.3.0")
	}
}

plugins {
	java
	id("org.flywaydb.flyway") version "11.3.0"
	id("org.springframework.boot") version "3.4.2"
	id("io.spring.dependency-management") version "1.1.7"
}

group = "com.example"
version = "0.0.1-SNAPSHOT"

java {
	toolchain {
		languageVersion = JavaLanguageVersion.of(21)
	}
}

repositories {
	mavenCentral()
}

extra["flyway.version"] = "11.3.0"

dependencies {
	implementation("org.springframework.boot:spring-boot-starter-data-jpa")
	implementation("org.flywaydb:flyway-core")
	implementation("org.flywaydb:flyway-database-postgresql")
	implementation(platform("org.testcontainers:testcontainers-bom:1.20.4"))
	testImplementation("org.testcontainers:postgresql")
	runtimeOnly("org.postgresql:postgresql")
	testImplementation("org.springframework.boot:spring-boot-starter-test")
	testRuntimeOnly("org.junit.platform:junit-platform-launcher")
}



tasks.withType<Test> {
	useJUnitPlatform()
}

flyway{
	url = "jdbc:postgresql://localhost:5432/bravadb_catalog"
	user = "user"
	password = "password"
	locations = arrayOf("classpath:db/migration")
}
