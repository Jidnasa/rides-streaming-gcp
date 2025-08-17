
const { process, _test } = require('../normalize');

test('sanitizeNumber handles noise', () => {
  expect(_test.sanitizeNumber('"737.0"')).toBeCloseTo(737.0);
  expect(_test.sanitizeNumber('48.21km')).toBeCloseTo(48.21);
  expect(_test.sanitizeNumber('NaN')).toBeNull();
});

test('process maps keys', () => {
  const line = JSON.stringify({"Date":"2024-09-16","Time":"22:08:00","Booking ID":"\"CNR1950162\"","Booking Status":"Completed","Customer ID":"\"CID9933542\"","Vehicle Type":"Bike","Pickup Location":"Ghitorni Village","Drop Location":"Khan Market","Avg VTAT":5.3,"Avg CTAT":19.6,"Cancelled Rides by Customer":null,"Reason for cancelling by Customer":null,"Cancelled Rides by Driver":null,"Driver Cancellation Reason":null,"Incomplete Rides":null,"Incomplete Rides Reason":null,"Booking Value":737.0,"Ride Distance":48.21,"Driver Ratings":4.1,"Customer Rating":4.3,"Payment Method":"UPI"});
  const out = process(line);
  expect(out.booking_id).toBe('CNR1950162');
  expect(out.payment_method).toBe('UPI');
  expect(out.booking_value).toBeCloseTo(737);
});
