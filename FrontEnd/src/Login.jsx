import { useState } from 'react';
import styled from 'styled-components';
import { useNavigate } from 'react-router-dom';
const Wrapper = styled.div`
    width: 100%;
    max-width: 400px;
    margin: 0 auto;
    padding: 20px;
    border: 1px solid #ccc;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
`;

const Title = styled.h2`
    text-align: center;
    color: #333;
`;

const Form = styled.form`
    display: flex;
    flex-direction: column;
`;

const Label = styled.label`
    margin-bottom: 8px;
    color: #555;
`;

const Input = styled.input`
    padding: 8px;
    margin-bottom: 16px;
    border: 1px solid #ccc;
    border-radius: 4px;
`;

const Button = styled.button`
    padding: 10px;
    background-color: #007bff;
    color: #fff;
    border: none;
    border-radius: 4px;
    cursor: pointer;

    &:hover {
        background-color: #0056b3;
    }
`;

// Rest of your component remains unchanged

const Login = () => {
    const navigate = useNavigate();
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [loginMessage, setLoginMessage] = useState('');

    const handleLogin = async () => {
        try {
            const response = await fetch('http://127.0.0.1:8000/api/api/login/', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ correo: email, contrasena: password }),
            });

            if (response.ok) {
                // Login successful
                const responseData = await response.json();
                setLoginMessage(responseData.detail);
                // Handle success (e.g., redirect)
                console.log('Login successful!');
                navigate('/CrudRoles'); 
            } else {
                // Login failed, handle error
                const errorText = await response.text();
                setLoginMessage(`Login failed! Status: ${response.status}, Error: ${errorText}`);
                console.log(`Login failed! Status: ${response.status}, Error: ${errorText}`);
            }
        } catch (error) {
            console.error('Error during login:', error);
        }
    };


    return (
        <Wrapper>
            <Title>Login</Title>
            <Form>
                <Label>Email:</Label>
                <Input
                    type="email"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                />
                <Label>Password:</Label>
                <Input
                    type="password"
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                />
                <Button type="button" onClick={handleLogin}>
                    Login
                </Button>
                {loginMessage && <p>{loginMessage}</p>}
            </Form>
        </Wrapper>
    );
};

export default Login;
