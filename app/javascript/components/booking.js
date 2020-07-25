import flatpickr from 'flatpickr';

const toggleDateInputs = () => {
  const startDateInput = document.querySelector("#booking_start_date");
  const endDateInput = document.querySelector("#booking_end_date");

  if (startDateInput && endDateInput) {
    // Passing the unavailable dates from the back-end to the front-end
    const unavailableDates = JSON.parse(document.querySelector('#booking_start_date').dataset.unavailable);
    flatpickr(startDateInput, {
      minDate: 'today',
      dateFormat: "d-m-Y",
      disable: unavailableDates,
      onChange: function(selectedDates, selectedDate) {
        if (selectedDate === '') {
          endDateInput.disabled = true;
        }
        let minDate = selectedDates[0];
        minDate.setDate(minDate.getDate() + 1);
        // Setting the minimum date of the end date input
        endDateCalendar.set('minDate', minDate);
        endDateInput.disabled = false;
      }
    });

    const endDateCalendar = flatpickr(endDateInput, {
      dateFormat: "d-m-Y",
      disable: unavailableDates
    });

  }
}

export { toggleDateInputs };