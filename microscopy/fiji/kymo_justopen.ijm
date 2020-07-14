run("Z Project...", "projection=[Max Intensity] all");
run("Enhance Contrast", "saturated=0.35");
wait(3000);
setMetadata("original_path", File.directory());
