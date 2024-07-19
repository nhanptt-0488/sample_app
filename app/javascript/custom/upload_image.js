document.addEventListener("turbo:load", function() {
  document.addEventListener("change", function(event) {
    let image_upload = document.querySelector('#micropost_image');
    
    // Kiểm tra nếu phần tử bị thay đổi là phần tử #micropost_image
    if (event.target === image_upload && image_upload.files.length > 0) {
      const size_in_megabytes = image_upload.files[0].size / 1024 / 1024;
      if (size_in_megabytes > 5) {
        alert(I18n.t("images.alert"));
        image_upload.value = "";
      }
    }
  });
});
