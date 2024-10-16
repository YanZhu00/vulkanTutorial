workspace "VulkanTutorial"
	architecture "x64"
	startproject "VulkanT"

	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

-- Include directories relative to root folder (solution directory)
IncludeDir = {}
IncludeDir["GLFW"] = "VulkanT/vendor/glfw/include"
IncludeDir["glm"] = "VulkanT/vendor/glm"


group "Dependencies"
	include "VulkanT/vendor/glfw"
group ""


project "VulkanT"
	location "VulkanT"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")


	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp",
		"%{prj.name}/vendor/glm/glm/**.hpp",
		"%{prj.name}/vendor/glm/glm/**.inl",
	}

	defines
	{
		"_CRT_SECURE_NO_WARNINGS"
	}

	includedirs
	{
		"%{prj.name}/src",
		"%{IncludeDir.GLFW}",
		"%{IncludeDir.glm}",
		"$(VULKAN_SDK)/include"
	}

	links 
	{ 
		"GLFW",
		"$(VULKAN_SDK)/lib/vulkan-1.lib"
	}

	filter "system:windows"
		systemversion "latest"

		defines
		{
			"GLFW_INCLUDE_NONE"
		}

	filter "configurations:Debug"
		defines "VulkanT_DEBUG"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		defines "VulkanT_RELEASE"
		runtime "Release"
		optimize "on"

	filter "configurations:Dist"
		defines "VulkanT_DIST"
		runtime "Release"
		optimize "on"

