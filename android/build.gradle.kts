import org.gradle.api.tasks.Delete
import org.gradle.api.file.Directory

allprojects {
   repositories {
    google()
    mavenCentral()
    maven("https://jitpack.io")
   }

}

/**
 * مهم جدًا:
 * نجبر Gradle يستخدم NDK ثابت وسليم
 * ومايرجعش تاني لـ NDK 28 البايظ
 */
subprojects {
    afterEvaluate {
        extensions.findByName("android")?.let { ext ->

            if (ext is com.android.build.gradle.AppExtension) {
                ext.ndkVersion = "26.1.10909125"
            }

            if (ext is com.android.build.gradle.LibraryExtension) {
                ext.ndkVersion = "26.1.10909125"
            }

        }
    }
}


// تغيير مكان build directory
val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()

rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

// مهمة clean
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
