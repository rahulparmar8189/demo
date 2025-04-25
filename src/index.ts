import express, { Request, Response } from 'express';

const app = express();
const port = process.env.PORT || 3000;

// Middleware
app.use(express.json());

// Test API endpoint
app.get('/api/test', (req: Request, res: Response) => {
  res.json({
    success: true,
    message: 'API is working successfully!',
    timestamp: new Date().toISOString()
  });
});

// Start the server
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
}); 