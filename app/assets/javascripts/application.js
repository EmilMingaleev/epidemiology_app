function openModal(imageSrc) {
    document.getElementById('qrModalImage').src = imageSrc;
    document.getElementById('qrModal').classList.remove('hidden');
    document.getElementById('qrModal').classList.add('flex');
  }
  
  function closeModal() {
    document.getElementById('qrModal').classList.add('hidden');
    document.getElementById('qrModal').classList.remove('flex');
  }
  