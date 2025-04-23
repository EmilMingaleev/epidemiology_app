function openModal(imageSrc) {
    document.getElementById('qrModalImage').src = imageSrc;
    document.getElementById('qrModal').classList.remove('hidden');
    document.getElementById('qrModal').classList.add('flex');
  }
  
  function closeModal() {
    document.getElementById('qrModal').classList.add('hidden');
    document.getElementById('qrModal').classList.remove('flex');
  }

  function openImageInNewWindow(imageSrc) {
    const newWindow = window.open(imageSrc, '_blank', 'width=1200,height=800,scrollbars=yes');
    newWindow.document.title = "Просмотр изображения";
  }