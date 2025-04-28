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
  
  function openDoctorModal(id) {
    const modal = document.getElementById(`doctorModal-${id}`);
    modal.classList.remove("hidden");
    modal.classList.add("flex");
  }

  function closeDoctorModal(id) {
    const modal = document.getElementById(`doctorModal-${id}`);
    modal.classList.add("hidden");
    modal.classList.remove("flex");
  }
