buildscript {
    repositories {
        google()  // إضافة مستودع Google
        mavenCentral()  // إضافة مستودع Maven Central
    }
    dependencies {
        classpath("com.android.tools.build:gradle:8.0.0")  // الـ Gradle Plugin
        classpath("com.google.gms:google-services:4.3.15")  // Google Services Plugin
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
