const calculateAmount = () => {
  const startDateInput = document.querySelector("#booking_start_date");
  const endDateInput = document.querySelector("#booking_end_date");
  const formAmount = document.querySelector("#booking_amount");
  let start_date;
  let end_date;
  let amount = "";
  console.log("Start date input: ", startDateInput);
  console.log("End date input: ", endDateInput);

  if (startDateInput && endDateInput && formAmount) {
    const daily_price = parseInt(formAmount.dataset.carPrice, 10);
    startDateInput.addEventListener('input', () => {
      start_date = new Date(startDateInput.value.slice(6, 8), startDateInput.value.slice(3, 5), startDateInput.value.slice(0, 2));
      console.log("start_date= ", start_date);
      if (calculateDays(end_date, start_date) > 0) {
        amount = (calculateDays(end_date, start_date) + 1) * daily_price;
      } else {
        amount = "";
      }
      console.log("-2-", amount);
      formAmount.value = amount;
      return amount;
    })

    endDateInput.addEventListener('input', () => {
      end_date = new Date(endDateInput.value.slice(6, 8), endDateInput.value.slice(3, 5), endDateInput.value.slice(0, 2));
      console.log("end_date= ", end_date);
      if (calculateDays(end_date, start_date) > 0) {
        amount = (calculateDays(end_date, start_date) + 1)  * daily_price;
      } else {
        amount = "";
      }
      console.log("-4-", amount);
      formAmount.value = amount;
      return amount;
    })
    
  }

  const calculateDays = (end_date, start_date) => {
    if (end_date > start_date) {
      return (end_date - start_date) / (1000 * 60 * 60 * 24);
    } else {
      return 0;
    }
  }
}

  

export { calculateAmount };