
function sanitizeNumber(x) {
  if (x === null || x === undefined) return null;
  const s = String(x).toLowerCase().replace(/[^0-9.\-]/g, '').trim();
  if (!s) return null;
  const n = Number(s);
  return isFinite(n) ? n : null;
}
function cleanStr(x) { if (x === null || x === undefined) return null; const s = String(x).trim(); return s === '' ? null : s; }
function process(line) {
  let obj; try { obj = JSON.parse(line); } catch(e) { return { __error: 'invalid_json', __raw: line }; }
  return {
    date: cleanStr(obj['Date'] ?? obj['date']),
    time: cleanStr(obj['Time'] ?? obj['time']),
    booking_id: cleanStr((obj['Booking ID'] ?? obj['booking_id'] ?? '').replace(/"/g,'')),
    booking_status: cleanStr(obj['Booking Status'] ?? obj['booking_status']),
    customer_id: cleanStr((obj['Customer ID'] ?? obj['customer_id'] ?? '').replace(/"/g,'')),
    vehicle_type: cleanStr(obj['Vehicle Type'] ?? obj['vehicle_type']),
    pickup_location: cleanStr(obj['Pickup Location'] ?? obj['pickup_location']),
    drop_location: cleanStr(obj['Drop Location'] ?? obj['drop_location']),
    avg_vtat: sanitizeNumber(obj['Avg VTAT'] ?? obj['avg_vtat']),
    avg_ctat: sanitizeNumber(obj['Avg CTAT'] ?? obj['avg_ctat']),
    cancelled_by_customer: sanitizeNumber(obj['Cancelled Rides by Customer'] ?? obj['cancelled_by_customer']),
    customer_cancel_reason: cleanStr(obj['Reason for cancelling by Customer'] ?? obj['customer_cancel_reason']),
    cancelled_by_driver: sanitizeNumber(obj['Cancelled Rides by Driver'] ?? obj['cancelled_by_driver']),
    driver_cancel_reason: cleanStr(obj['Driver Cancellation Reason'] ?? obj['driver_cancel_reason']),
    incomplete_rides: sanitizeNumber(obj['Incomplete Rides'] ?? obj['incomplete_rides']),
    incomplete_reason: cleanStr(obj['Incomplete Rides Reason'] ?? obj['incomplete_reason']),
    booking_value: sanitizeNumber(obj['Booking Value'] ?? obj['booking_value']),
    ride_distance: sanitizeNumber(obj['Ride Distance'] ?? obj['ride_distance']),
    driver_ratings: sanitizeNumber(obj['Driver Ratings'] ?? obj['driver_ratings']),
    customer_rating: sanitizeNumber(obj['Customer Rating'] ?? obj['customer_rating']),
    payment_method: cleanStr(obj['Payment Method'] ?? obj['payment_method'])
  };
}
module.exports = { process, _test: { sanitizeNumber, cleanStr } };
