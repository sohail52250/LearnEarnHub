const service = require('../services/sourcing-service');

module.exports = async function(req, res) {
  try {
    if (req.method === 'GET') {
      const action = String(req.query?.action || 'suppliers').trim().toLowerCase();
      if (action === 'suppliers') {
        const suppliers = await service.listSuppliers({ limit: req.query?.limit });
        return res.status(200).json({ success: true, suppliers, count: suppliers.length });
      }
      if (action === 'my-requests') {
        const requests = await service.listMyRequests(req);
        return res.status(200).json({ success: true, requests, count: requests.length });
      }
      return res.status(400).json({ success:false, error:'Invalid sourcing action.' });
    }

    if (req.method !== 'POST') return res.status(405).json({ success:false, error:'Method not allowed.' });
    const body = req.body || {};
    const action = String(body.action || 'create-request').trim().toLowerCase();
    if (action === 'create-request') {
      const request = await service.createRequest(req, body);
      return res.status(201).json({ success:true, request });
    }
    if (action === 'create-quote') {
      const quotation = await service.createQuote(req, body);
      return res.status(201).json({ success:true, quotation });
    }
    return res.status(400).json({ success:false, error:'Invalid sourcing action.' });
  } catch (error) {
    console.error('SOURCING API ERROR:', error);
    return res.status(error.status || 500).json({ success:false, error:error.message || 'Sourcing operation failed.' });
  }
};
