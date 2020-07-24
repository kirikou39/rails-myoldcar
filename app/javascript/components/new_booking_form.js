const calculateAmount = () => {
  const startDateInput = document.querySelector("#booking_start_date");
  const endDateInput = document.querySelector("#booking_end_date");
  const formAmount = document.querySelector("#booking_amount");
  const daily_price = 100;
  let start_date;
  let end_date;
  let amount;

  startDateInput.addEventListener('input', () => {
    start_date = new Date(startDateInput.value);

    if (calculateDays(end_date, start_date) > 0) {
      amount = calculateDays(end_date, start_date) * daily_price;
    } else {
      amount = "";
    }
    console.log("-2-", amount);
    formAmount.value = amount;
    return amount;
  })

  endDateInput.addEventListener('input', () => {
    end_date = new Date(endDateInput.value);

    if (calculateDays(end_date, start_date) > 0) {
      amount = calculateDays(end_date, start_date) * daily_price;
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

export { calculateAmount };