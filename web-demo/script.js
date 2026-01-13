// Screen Navigation
function showScreen(screenId) {
    document.querySelectorAll('.screen').forEach(screen => {
        screen.classList.remove('active');
    });
    document.getElementById(screenId).classList.add('active');
}

// Hub Selection
function selectHub(element) {
    document.querySelectorAll('.hub-card').forEach(card => {
        card.classList.remove('selected');
    });
    element.classList.add('selected');
}

// Confirm Delivery
function confirmDelivery() {
    alert('✅ Delivery request confirmed! A traveler will pick up your parcel from the selected hub.');
    showScreen('home-screen');
}

// Draw Chart
function drawChart() {
    const canvas = document.getElementById('costChart');
    if (!canvas) return;

    const ctx = canvas.getContext('2d');
    const width = canvas.width;
    const height = canvas.height;

    // Clear canvas
    ctx.clearRect(0, 0, width, height);

    // Grid lines
    ctx.strokeStyle = '#f0f0f0';
    ctx.lineWidth = 1;
    for (let i = 0; i <= 5; i++) {
        const y = (height / 5) * i;
        ctx.beginPath();
        ctx.moveTo(40, y);
        ctx.lineTo(width, y);
        ctx.stroke();
    }

    // Y-axis labels
    ctx.fillStyle = '#666';
    ctx.font = '11px Arial';
    ctx.textAlign = 'right';
    for (let i = 0; i <= 5; i++) {
        const value = 250 - (i * 50);
        const y = (height / 5) * i + 4;
        ctx.fillText('₹' + value, 35, y);
    }

    // X-axis labels
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
    ctx.textAlign = 'center';
    months.forEach((month, i) => {
        const x = 40 + ((width - 40) / 6) * (i + 0.5);
        ctx.fillText(month, x, height - 5);
    });

    // Data points
    const traditional = [120, 140, 160, 180, 200, 220];
    const p2p = [45, 50, 40, 55, 48, 52];

    // Draw Traditional line (red)
    ctx.strokeStyle = '#FF5252';
    ctx.lineWidth = 3;
    ctx.beginPath();
    traditional.forEach((value, i) => {
        const x = 40 + ((width - 40) / 6) * (i + 0.5);
        const y = height - 20 - ((value / 250) * (height - 40));
        if (i === 0) {
            ctx.moveTo(x, y);
        } else {
            ctx.lineTo(x, y);
        }
    });
    ctx.stroke();

    // Draw dots for traditional
    ctx.fillStyle = '#FF5252';
    traditional.forEach((value, i) => {
        const x = 40 + ((width - 40) / 6) * (i + 0.5);
        const y = height - 20 - ((value / 250) * (height - 40));
        ctx.beginPath();
        ctx.arc(x, y, 4, 0, Math.PI * 2);
        ctx.fill();
    });

    // Draw P2P line (green)
    ctx.strokeStyle = '#00C853';
    ctx.lineWidth = 3;
    ctx.beginPath();
    p2p.forEach((value, i) => {
        const x = 40 + ((width - 40) / 6) * (i + 0.5);
        const y = height - 20 - ((value / 250) * (height - 40));
        if (i === 0) {
            ctx.moveTo(x, y);
        } else {
            ctx.lineTo(x, y);
        }
    });
    ctx.stroke();

    // Draw dots for P2P
    ctx.fillStyle = '#00C853';
    p2p.forEach((value, i) => {
        const x = 40 + ((width - 40) / 6) * (i + 0.5);
        const y = height - 20 - ((value / 250) * (height - 40));
        ctx.beginPath();
        ctx.arc(x, y, 4, 0, Math.PI * 2);
        ctx.fill();
    });
}

// Initialize on load
window.addEventListener('load', () => {
    drawChart();
});

// Redraw chart when dashboard is shown
const observer = new MutationObserver((mutations) => {
    mutations.forEach((mutation) => {
        if (mutation.target.id === 'dashboard-screen' &&
            mutation.target.classList.contains('active')) {
            setTimeout(drawChart, 100);
        }
    });
});

document.querySelectorAll('.screen').forEach(screen => {
    observer.observe(screen, { attributes: true, attributeFilter: ['class'] });
});
