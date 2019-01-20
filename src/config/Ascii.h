#pragma once
const std::string windowsAsciiArt ="";
const std::string nonWindowsAsciiArt = "";
#ifdef _WIN32
const std::string asciiArt = windowsAsciiArt;
#else
const std::string asciiArt = nonWindowsAsciiArt;
#endif
